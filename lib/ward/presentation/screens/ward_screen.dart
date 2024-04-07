import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/data/models/store.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/screens/ward_settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../components/settings_button.dart';

class WardScreen extends StatefulWidget {

  final Ward ward;

  const WardScreen({super.key, required this.ward});

  @override
  State<WardScreen> createState() => _WardScreenState();
}

class _WardScreenState extends State<WardScreen> {

  late WardsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<WardsBloc>();
    bloc.add(GetAllStoresEvent(widget.ward.id ?? -1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: BlocBuilder<WardsBloc, WardsState>(
              builder: (context, state) {
                if (state.getAllStoresState == RequestState.loading) {
                  return const LoadingScreen();
                } else if (state.getAllStoresState == RequestState.error) {
                  return ErrorScreen(error: state.getAllStoresMessage);
                }
                List<Store> stores = state.stores;
                List<int> indexes = [];
                Map<int, String> map = {};
                debugPrint('=========== stores ${stores.length}');
                for (var element in stores) {
                  int x = (element.xAxies ?? 0);
                  int y = (element.yAxies ?? 0);
                  int width = widget.ward.width ?? 1;
                  int height = widget.ward.height ?? 1;
                  debugPrint('========= x $x y $y width $width height $height');
                  int newIndex = (x - 1) * width + (y - 1);
                  indexes.add(newIndex);
                  map[newIndex] = element.product ?? '';
                  debugPrint('=========== new $newIndex');
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const MainAppBar(canNavigateUp: true,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SecondaryAppBarWithImage(
                          text: widget.ward.name ?? '',
                          image: AppAssets.goods,
                        ),
                        SettingsButton(onTab: () {
                          NavigateUtil().navigateToScreen(context,
                              BlocProvider.value(value: instance<WardsBloc>(),
                                  child: WardSettingsScreen(
                                    ward: widget.ward,)));
                        },
                        ),
                      ],
                    ),
                    GridView.count(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 28),
                        crossAxisCount: widget.ward.width ?? 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.1,
                        children: List.generate((widget.ward.width ?? 1) *
                            (widget.ward.height ?? 1), (index) {
                          return indexes.contains(index) ? InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: context.width,
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        16.ph,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  NavigateUtil().navigateUp(context);
                                                },
                                                icon: const Icon(Icons.close)
                                            ),
                                            Expanded(child: Container()),
                                            Image.asset(
                                              AppAssets.package,
                                              width: 60,
                                              height: 60,
                                            ),
                                            Expanded(child: Container()),
                                            16.pw,
                                          ],
                                        ),
                                        16.ph,
                                        const Divider(
                                          height: 1,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffDDB089),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  )
                                ]
                              ),
                              child: Center(
                                child: Text(
                                  indexes.contains(index) ? map[index] ?? '' : '',
                                  style: getSmallStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeightManager.medium
                                  ),
                                ),
                              ),
                            ),
                          )
                          :
                          DottedBorder(
                            strokeWidth: 1,
                            child: Container(),
                          );
                        })
                    )
                  ],
                );
              },
            ),
          ),
        )
    );
  }
}
