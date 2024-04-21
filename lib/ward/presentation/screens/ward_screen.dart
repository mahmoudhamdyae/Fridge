import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/components/client_details_button.dart';
import 'package:fridge/ward/presentation/screens/invoice_screen.dart';
import 'package:fridge/ward/presentation/screens/ward_settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../domain/entities/store.dart';
import '../../../core/components/settings_button.dart';

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
    bloc.add(GetAllStoresEvent(widget.ward));
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
            const MainAppBar(
              canNavigateUp: true,
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
                    int width = widget.ward.width ?? 1;
                    int height = widget.ward.height ?? 1;
                    debugPrint('========= x $x y $y width $width height $height');
                    int newIndex = (x) * width + (y);
                    indexes.add(newIndex);
                    map[newIndex] = element;
                    debugPrint('=========== new $newIndex');
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecondaryAppBarWithImage(
                            text: widget.ward.name ?? '',
                            image: AppAssets.goods,
                          ),
                          SettingsButton(
                            onTab: () {
                              NavigateUtil().navigateToScreen(
                                  context,
                                  BlocProvider.value(
                                      value: instance<WardsBloc>(),
                                      child: WardSettingsScreen(
                                        ward: widget.ward,
                                      )));
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
                          children: List.generate(
                              (widget.ward.width ?? 1) * (widget.ward.height ?? 1),
                                  (index) {
                                String text = '';
                                // debugPrint('hahahahahahahaha${map}');
                                for (var element in indexes) {
                                  if (element == index) {
                                    if (text != '') {
                                      text += ' + ';
                                    }
                                    text += map[element]?.product?? '';
                                    debugPrint('hahahahahahahaha${map[element]?.product}');
                                  }
                                }

                                return indexes.contains(index)
                                    ? InkWell(
                                  onTap: () {
                                    buildShowModalBottomSheet(context, state, map[index]?.x ?? 0, map[index]?.y ?? 0);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xffDDB089),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.black,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          )
                                        ]),
                                    child: Center(
                                      child: Text(
                                        text,
                                        style: getSmallStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeightManager.medium),
                                      ),
                                    ),
                                  ),
                                )
                                    : DottedBorder(
                                  strokeWidth: 1,
                                  child: Container(),
                                );
                              }))
                    ],
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

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, GetStoreLoadedState state, int x, int y) {
    List<Store> stores = state.stores.where((element) =>
    element.x == x && element.y == y).toList();
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: context.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              16.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        NavigateUtil().navigateUp(context);
                      },
                      icon: const Icon(Icons.close)),
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
              16.ph,
              SizedBox(
                height: context.dynamicHeight(.4),
                child: ListView(
                  children: [
                    ...List.generate(
                        stores.length, (index) {
                      StoreCustomer? customer = stores[index].customer;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.productDialogClientName,
                                style: getSmallStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                customer?.name ?? '',
                                style: getSmallStyle(
                                  fontSize: 18,
                                ),
                              ),
                              8.pw,
                              Text(
                                customer?.type == 0 ? AppStrings.addClientScreenTraderWithQ : AppStrings.addClientScreenDealerWithQ,
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          8.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppStrings.productDialogProduct,
                                    style: getSmallStyle(),
                                  ),
                                  Text(
                                    stores[index].product ?? '',
                                    style: getSmallStyle(
                                      color: const Color(0xff6B6B6B),
                                    ),
                                  ),
                                ],
                              ),
                              0.pw,
                              Row(
                                children: [
                                  Text(
                                    AppStrings.productDialogQuantity,
                                    style: getSmallStyle(),
                                  ),
                                  Text(
                                    '${stores[index].totalWeight} ${stores[index].unit}',
                                    style: getSmallStyle(
                                      color: const Color(0xff6B6B6B),
                                    ),
                                  ),
                                ],
                              ),
                              0.pw,
                            ],
                          ),
                          16.ph,
                          SizedBox(
                            width: context.dynamicWidth(.8),
                            child: SheetClientDetailsButton(onTap: () {
                              NavigateUtil().navigateUp(context);
                              NavigateUtil().navigateToScreen(
                                context,
                                BlocProvider.value(
                                  value: instance<WardsBloc>(),
                                  child: InvoiceScreen(
                                    storeId: stores[index].id ?? -1,
                                  ),
                                ),
                              );
                            }),
                          ),
                          16.ph,
                          const Divider(
                            height: 1,
                            color: AppColors.grey,
                          ),
                          16.ph,
                        ],
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
