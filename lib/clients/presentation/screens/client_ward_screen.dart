import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/components/states/error_screen.dart';
import '../../../core/components/states/loading_screen.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../../ward/domain/entities/store.dart';
import '../../../ward/domain/entities/ward.dart';
import '../../../ward/presentation/bloc/wards_bloc.dart';

class ClientWardScreen extends StatefulWidget {
  
  final int wardId;
  final int x;
  final int y;
  const ClientWardScreen({super.key, required this.wardId, required this.x, required this.y});

  @override
  State<ClientWardScreen> createState() => _ClientWardScreenState();
}

class _ClientWardScreenState extends State<ClientWardScreen> {

  late WardsBloc bloc;
  Ward? ward;

  @override
  void initState() {
    super.initState();
    bloc = instance<WardsBloc>();
    bloc.add(GetWardsEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<WardsBloc, WardsState>(
      listenWhen: (previous, current) => current is GetWardsLoadedState,
  listener: (context, state) {
        if (state is GetWardsLoadedState) {
          setState(() {
            ward = state.wards.firstWhere((element) => element.id == widget.wardId);
          });
          bloc.add(GetAllStoresEvent(ward!));
        }
  },
  child: SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(
                  canNavigateUp: true,
                ),
                SecondaryAppBarWithImage(
                  text: ward?.name ?? '',
                  image: AppAssets.goods,
                ),
                BlocBuilder<WardsBloc, WardsState>(
                  buildWhen: (previousState, state) =>
                  state is GetStoreLoadingState ||
                      state is GetStoreErrorState ||
                      state is GetStoreLoadedState,
                  builder: (context, state) {
                    if (state is GetStoreLoadingState) {
                      return const LoadingScreen();
                    } else if (state is GetStoreErrorState) {
                      return ErrorScreen(error: state.errorMessage);
                    } else if (state is GetStoreLoadedState) {
                      List<Store> stores = state.stores;
                      List<int> indexes = [];
                      Map<int, Store> map = {};
                      debugPrint('=========== stores ${stores.length}');
                      for (var element in stores) {
                        int x = (element.x ?? 0);
                        int y = (element.y ?? 0);
                        int width = ward?.width ?? 1;
                        int height = ward?.height ?? 1;
                        debugPrint('========= x $x y $y width $width height $height');
                        int newIndex = (x) * width + (y);
                        indexes.add(newIndex);
                        map[newIndex] = element;
                        debugPrint('=========== new $newIndex');
                      }
                      return GridView.count(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 28),
                          crossAxisCount: ward?.width ?? 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.1,
                          children: List.generate(
                              (ward?.width ?? 1) * (ward?.height ?? 1),
                                  (index) {
                                return indexes.contains(index)
                                    ? Container(
                                      decoration: BoxDecoration(
                                          color: ((widget.x) * (ward!.width ?? 0) + (widget.y)) == index ? AppColors.colorRamps3 : const Color(0xffDDB089),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.black,
                                              blurRadius: 4,
                                              offset: Offset(2, 2),
                                            )
                                          ]),
                                      child: Center(
                                        child: Text(
                                          indexes.contains(index)
                                              ? map[index]?.product ?? ''
                                              : '',
                                          style: getSmallStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeightManager.medium,
                                              color: ((widget.x) * (ward!.width ?? 0) + (widget.y)) == index ? AppColors.white : AppColors.black,
                                          )
                                        ),
                                      ),
                                    )
                                    : DottedBorder(
                                  strokeWidth: 1,
                                  child: Container(),
                                );
                              }));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        )),
);
  }
}
