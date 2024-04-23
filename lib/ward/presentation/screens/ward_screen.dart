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
import 'package:fridge/ward/presentation/screens/ward_settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../domain/entities/store.dart';
import '../../../core/components/settings_button.dart';
import '../components/build_bottom_sheet.dart';

class WardScreen extends StatefulWidget {
  final Ward ward;

  const WardScreen({super.key, required this.ward});

  @override
  State<WardScreen> createState() => _WardScreenState();
}

class _WardScreenState extends State<WardScreen> {
  late WardsBloc bloc;
  String searchString = '';

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
                      24.ph,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          decoration: getFilledTextFieldDecoration(
                              hint: AppStrings.wardsScreenSearchHint,
                              radius: 20.0,
                              prefixIcon: Icons.search,
                              textStyle: getSmallStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeightManager.medium,
                                  color: AppColors.dark2
                              )
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              searchString = value;
                            });
                          },
                        ),
                      ),
                      16.ph,
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
                                int x = map[index]?.x ?? 0;
                                int y = map[index]?.y ?? 0;
                                List<Store> stores = state.stores.where((element) =>
                                element.x == x && element.y == y).toList();
                                for (var element in stores) {
                                  if (text != '') {
                                    text += ' + ';
                                  }
                                  text += element.product?? '';
                                }

                                return indexes.contains(index)
                                    ? InkWell(
                                  onTap: () {
                                    int x = map[index]?.x ?? 0;
                                    int y = map[index]?.y ?? 0;
                                    List<Store> stores = state.stores.where((element) =>
                                    element.x == x && element.y == y).toList();
                                    buildShowModalBottomSheet(context, stores);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                        searchString.isNotEmpty && (
                                            map[index]!.product!.toLowerCase().contains(searchString.toLowerCase()) ||
                                                map[index]!.customer!.name!.toLowerCase().contains(searchString.toLowerCase()) ||
                                                map[index]!.customer!.phone!.contains(searchString.toLowerCase()))
                                            ?
                                        AppColors.colorRamps3
                                            :
                                        const Color(0xffDDB089),
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
                                        text,
                                        textAlign: TextAlign.center,
                                        style: getSmallStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeightManager.medium,
                                          color:
                                          searchString.isNotEmpty && (
                                              map[index]!.product!.toLowerCase().contains(searchString.toLowerCase()) ||
                                                  map[index]!.customer!.name!.toLowerCase().contains(searchString.toLowerCase()) ||
                                                  map[index]!.customer!.phone!.contains(searchString.toLowerCase()))
                                              ?
                                          AppColors.white
                                              :
                                          AppColors.black,
                                        ),
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
}
