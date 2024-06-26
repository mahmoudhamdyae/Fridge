import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/core/components/settings_button.dart';
import 'package:fridge/ward/presentation/screens/ward_screen.dart';

import '../../../core/components/decorations.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class WardsScreen extends StatefulWidget {

  final BuildContext blocContext;

  const WardsScreen({super.key, required this.blocContext});

  @override
  State<WardsScreen> createState() => _WardsScreenState();
}

class _WardsScreenState extends State<WardsScreen> {

  late WardsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<WardsBloc>();
    bloc.add(GetWardsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SecondaryAppBarWithImage(
                      text: AppStrings.wardsScreenTitle,
                      image: AppAssets.goods,
                    ),
                    SettingsButton(
                      onTab: () {
                        NavigateUtil()
                            .navigateToScreen(
                            context, BlocProvider.value(
                            value: instance<SettingsBloc>(),
                            child: const SettingsScreen()
                        ));
                      },
                    ),
                  ],
                ),
                BlocBuilder<WardsBloc, WardsState>(
                  buildWhen: (previousState, state) =>
                  state is GetWardsLoadingState ||
                      state is GetWardsErrorState ||
                      state is GetWardsLoadedState,
                  builder: (context, state) {
                    if (state is GetWardsLoadingState) {
                      return const LoadingScreen();
                    } else if (state is GetWardsErrorState) {
                      return ErrorScreen(error: state.errorMessage);
                    } else if (state is GetWardsLoadedState) {
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 28),
                        crossAxisCount: 4,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.1,
                        children: List.generate(state.wards.length, (index) {
                          return InkWell(
                            onTap: () {
                              NavigateUtil().navigateToScreen(
                                  context,
                                  BlocProvider.value(
                                    value: instance<WardsBloc>(),
                                    child: WardScreen(ward: state.wards[index]),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff2E5AAF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  state.wards[index].name ?? '',
                                  style: getSmallStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeightManager.medium),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
