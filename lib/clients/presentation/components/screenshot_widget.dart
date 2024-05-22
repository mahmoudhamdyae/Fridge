import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/components/show_all_transactions_button.dart';
import 'package:fridge/core/components/dialogs/del_dialog.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../data/models/client_invoice.dart';
import '../screens/client_ward_screen.dart';
import 'edit_paid_dialog.dart';

class ScreenshotWidget extends StatelessWidget {
  final List<ClientInvoiceStores> stores;
  final String name;
  final bool isScreenshot;

  const ScreenshotWidget({
    super.key,
    required this.stores,
    required this.name,
    this.isScreenshot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.billScreenClientName,
              style: getSmallStyle(),
            ),
            Row(
              children: [
                32.pw,
                Text(
                  AppStrings.billScreenClientDate,
                  style: getSmallStyle(),
                ),
                Text(
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: getSmallStyle(
                    color: const Color(0xff5D5D5D),
                  ),
                ),
              ],
            ),
          ],
        ),
        8.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: getLargeStyle(
                fontSize: 22.0,
              ),
            ),
            isScreenshot ? Container() : const ShowAllTransactionsButton(),
          ],
        ),
        32.ph,
        Column(
          children: stores.map((store) {
            return InkWell(
              onTap: () {
                NavigateUtil().navigateToScreen(
                    context,
                    BlocProvider.value(
                      value: instance<WardsBloc>(),
                      child: ClientWardScreen(
                        wardId: store.fridgePartId ?? -1,
                        x: store.xAxies ?? -1,
                        y: store.yAxies ?? -1,
                      ),
                    ));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // المنتج
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenProduct,
                                style: getSmallStyle(),
                              ),
                              Text(
                                store.product ?? '',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          store.totalWeight != '0.000' ? 24.ph : 0.ph,
                          // الكمية
                          store.totalWeight != '0.000' ? Row(
                            children: [
                              Text(
                                AppStrings.billScreenQuantity,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${store.totalWeight} ${store.unit}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ) : Container(),
                          store.totalWeight == '0.000' ? 24.ph : 0.ph,
                          // عدد الشكاير
                          store.totalWeight == '0.000' ? Row(
                            children: [
                              Text(
                                AppStrings.billScreenNumber,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${store.quantity}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ) : Container(),
                          24.ph,
                          // رقم العنبر
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppStrings.billScreenWardsNumber,
                                    style: getSmallStyle(),
                                  ),
                                  Text(
                                    store.partName ?? '',
                                    style: getSmallStyle(
                                      color: const Color(0xff6B6B6B),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          24.ph,
                          // مكان التخزين
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenStorePlace,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${(store.xAxies ?? 0) + 1} * ${(store.yAxies ?? 0) + 1}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          24.ph,
                          // المبلغ المدفوع
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenPaid,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${(store.paid ?? 0)} ${AppStrings.egp}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          24.ph,
                          // المبلغ المتبقى
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenTotal,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${(store.totalWeight == '0.000' ? (store.totalBagPrice ?? 0) : (store.price ?? 0)) - (store.paid ?? 0)} ${AppStrings.egp}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      isScreenshot
                          ? Container()
                          : BlocListener<ClientsBloc, ClientsState>(
                              listenWhen: (previous, current) =>
                                  current.delStoreState == RequestState.error ||
                                  current.delStoreState == RequestState.loaded ||
                                  current.editPaidState == RequestState.error ||
                                  current.editPaidState == RequestState.loaded
                        ,
                              listener: (context, state) {
                                if (state.delStoreState == RequestState.error) {
                                  NavigateUtil().navigateUp(context);
                                  showError(context, state.delStoreErrorMessage,
                                      () {});
                                } else if (state.delStoreState ==
                                    RequestState.loaded) {
                                  NavigateUtil().navigateUp(context);
                                  BlocProvider.of<ClientsBloc>(context).add(
                                      GetClientInvoiceEvent(
                                          store.customerId ?? -1));
                                } else if (state.editPaidState == RequestState.error) {
                                  NavigateUtil().navigateUp(context);
                                  showError(context, state.delStoreErrorMessage,
                                          () {});
                                } else if (state.editPaidState ==
                                    RequestState.loaded) {
                                  NavigateUtil().navigateUp(context);
                                }
                              },
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDelDialog(
                                            context: context,
                                            text: AppStrings.delDialogStoreText,
                                            action: () {
                                              showLoading(context);
                                              BlocProvider.of<ClientsBloc>(context)
                                                  .add(DelStoreEvent(store.id ?? -1));
                                            }
                                        );
                                      },
                                      icon: const Icon(Icons.delete)),
                                  8.ph,
                                  IconButton(
                                      onPressed: () {
                                        showEditPaidDialog(
                                            context: context,
                                            action: (paid) {
                                              showLoading(context);
                                              BlocProvider.of<ClientsBloc>(context)
                                                  .add(EditPaidEvent(paid, store.id ?? -1));
                                            }
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
