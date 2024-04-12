import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../ward/domain/entities/store.dart';
import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';
import '../components/next_button.dart';

class ChooseWardSecondScreen extends StatefulWidget {
  final String productType;

  const ChooseWardSecondScreen({super.key, required this.productType});

  @override
  State<ChooseWardSecondScreen> createState() => _ChooseWardSecondScreenState();
}

class _ChooseWardSecondScreenState extends State<ChooseWardSecondScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsBloc, ClientsState>(
      builder: (context, state) {
        if (state.getStoresState == RequestState.loading) {
          return const LoadingScreen();
        } else if (state.getStoresState == RequestState.error) {
          return ErrorScreen(error: state.getStoresErrorMessage);
        }
        List<Store> stores = state.stores;
        List<int> indexes = [];
        Map<int, Store> map = {};
        debugPrint('=========== stores ${stores.length}');
        for (var element in stores) {
          int x = (element.x ?? 0);
          int y = (element.y ?? 0);
          int width = state.ward.width ?? 1;
          int height = state.ward.height ?? 1;
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
            const SecondaryAppBarWithImage(
                text: AppStrings.addClientScreenChooseWardProduct,
                image: AppAssets.person),
            // todo fridge name
            // 16.ph,
            // ThirdAppBar(
            //     text: '${state.ward.name}',
            //     image: AppAssets.goods),
            16.ph,
            GridView.count(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
              crossAxisCount: state.ward.width ?? 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: List.generate(
                  ((state.ward.width ?? 1) * (state.ward.height ?? 1)),
                  (index) {
                return InkWell(
                  onTap: () {
                    if (!indexes.contains(index)) {
                      setState(() {
                        selectedIndex = index;
                        debugPrint(
                            '======= index x ${((index) / (state.ward.width ?? 1)).floor()}');
                        debugPrint(
                            '======= index y ${((index) % (state.ward.width ?? 1))}');
                      });
                    } else {
                      // todo
                    }
                  },
                  child: DottedBorder(
                    color: indexes.contains(index) ? const Color(0x00ffffff) : AppColors.black,
                    child: Container(
                      decoration: indexes.contains(index) ? const BoxDecoration(
                          color: Color(0xffDDB089),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ]) : const BoxDecoration(),
                      child: Center(
                        child: Text(
                          indexes.contains(index)
                              ? map[index]?.product ?? ''
                              : selectedIndex == index
                                  ? widget.productType
                                  : '',
                          style: getSmallStyle(
                              fontSize: 12,
                              fontWeight: FontWeightManager.medium),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            // GridView.count(
            //     shrinkWrap: true,
            //     physics: const ClampingScrollPhysics(),
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 12, vertical: 28),
            //     crossAxisCount: state.ward.width ?? 1,
            //     crossAxisSpacing: 15,
            //     mainAxisSpacing: 20,
            //     childAspectRatio: 1.1,
            //     children: List.generate(
            //         (state.ward.width ?? 1) * (state.ward.height ?? 1),
            //             (index) {
            //           return indexes.contains(index)
            //               ? InkWell(
            //             onTap: () {
            //               setState(() {
            //                 selectedIndex = index;
            //                 debugPrint('======= index x ${((index) / (state.ward.width ?? 1)).floor()}');
            //                 debugPrint('======= index y ${((index) % (state.ward.width ?? 1))}');
            //               });
            //             },
            //             child: Container(
            //               decoration: const BoxDecoration(
            //                   color: Color(0xffDDB089),
            //                   borderRadius:
            //                   BorderRadius.all(Radius.circular(5)),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: AppColors.black,
            //                       blurRadius: 4,
            //                       offset: Offset(2, 2),
            //                     )
            //                   ]),
            //               child: Center(
            //                 child: Text(
            //                   indexes.contains(index)
            //                       ? map[index]?.product ?? ''
            //                       : '',
            //                   style: getSmallStyle(
            //                       fontSize: 10,
            //                       fontWeight: FontWeightManager.medium),
            //                 ),
            //               ),
            //             ),
            //           )
            //               : DottedBorder(
            //             strokeWidth: 1,
            //             child: Container(
            //               child: Center(
            //                 child: Text(
            //                     selectedIndex == index ? widget.productType : ''
            //                 ),
            //               ),
            //             ),
            //           );
            //         })),
            16.ph,
            NextButton(onClick: () {
              showLoading(context);
              BlocProvider.of<ClientsBloc>(context).add(FinishEvent(
                ((selectedIndex ?? 0) / (state.ward.width ?? 1)).floor(),
                ((selectedIndex ?? 0) % (state.ward.width ?? 1)),
              ));
            }),
            const CancelButton(),
          ],
        );
      },
    );
  }
}
