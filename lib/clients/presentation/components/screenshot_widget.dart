import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/components/sahb_button.dart';
import 'package:fridge/clients/presentation/components/sahb_dialog.dart';
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

class ScreenshotWidget extends StatelessWidget {
  final List<ClientInvoiceStores> stores;
  final String clientName;
  final int clientId;
  final bool isScreenshot;
  final int paid;
  final int remain;

  const ScreenshotWidget({
    super.key,
    required this.stores,
    required this.clientName,
    required this.clientId,
    this.isScreenshot = true,
    required this.paid,
    required this.remain,
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
              clientName,
              style: getLargeStyle(
                fontSize: 22.0,
              ),
            ),
            isScreenshot
                ? Container()
                : ShowAllTransactionsButton(
              amountPaid: paid,
              amountRemain: remain,
              clientName: clientName,
              clientId: clientId,
            ),
          ],
        ),
        24.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // المبلغ المدفوع
              Row(
                children: [
                  Text(
                    AppStrings.billScreenPaid,
                    style: getSmallStyle(),
                  ),
                  Text(
                    '$paid ${AppStrings.egp}',
                    style: getSmallStyle(
                      color: const Color(0xff6B6B6B),
                    ),
                  )
                ],
              ),
              // المبلغ المتبقى

              Row(
                children: [
                  Text(
                    AppStrings.billScreenTotal,
                    style: getSmallStyle(),
                  ),
                  Text(
                    '$remain ${AppStrings.egp}',
                    style: getSmallStyle(
                      color: const Color(0xff6B6B6B),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        24.ph,
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
                  child: Stack(
                    children: [
                      Row(
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
                              store.totalWeight != '0.000'
                                  ? Row(
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
                              )
                                  : Container(),
                              store.totalWeight == '0.000' ? 24.ph : 0.ph,
                              // عدد الشكاير
                              store.totalWeight == '0.000'
                                  ? Row(
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
                              )
                                  : Container(),
                              24.ph,
                              // رقم العنبر
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                    '${(store.xAxies ?? 0) + 1} * ${(store
                                        .yAxies ?? 0) + 1}',
                                    style: getSmallStyle(
                                      color: const Color(0xff6B6B6B),
                                    ),
                                  )
                                ],
                              ),
                              24.ph,
                              // التاريخ
                              Row(
                                children: [
                                  Text(
                                    AppStrings.billScreenDate,
                                    style: getSmallStyle(),
                                  ),
                                  Text(
                                    '${store.date}',
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
                            current.delStoreState ==
                                RequestState.error ||
                                current.delStoreState ==
                                    RequestState.loaded,
                            listener: (context, state) {
                              if (state.delStoreState ==
                                  RequestState.error) {
                                NavigateUtil().navigateUp(context);
                                showError(context,
                                    state.delStoreErrorMessage, () {});
                              } else if (state.delStoreState ==
                                  RequestState.loaded) {
                                NavigateUtil().navigateUp(context);
                                BlocProvider.of<ClientsBloc>(context).add(
                                    GetClientInvoiceEvent(
                                        store.customerId ?? -1));
                              }
                            },
                            child: IconButton(
                                onPressed: () {
                                  showDelDialog(
                                      context: context,
                                      text: AppStrings.delDialogStoreText,
                                      action: () {
                                        showLoading(context);
                                        BlocProvider.of<ClientsBloc>(
                                            context)
                                            .add(DelStoreEvent(
                                            store.id ?? -1));
                                      });
                                },
                                icon: const Icon(Icons.delete)),
                          )
                        ],
                      ),
                      isScreenshot
                          ? Container()
                          : Positioned(
                          bottom: 0,
                          left: 0,
                          child: BlocListener<ClientsBloc, ClientsState>(
                            listenWhen: (previous, current) =>
                            current.storeSahbState ==
                                RequestState.loaded ||
                                current.storeSahbState ==
                                    RequestState.error ||
                                current.storeSahbState ==
                                    RequestState.loading,
                            listener: (context, state) {
                              if (state.storeSahbState ==
                                  RequestState.error) {
                                NavigateUtil().navigateUp(context);
                                showError(context,
                                    state.storeSahbErrorMessage, () {});
                              } else if (state.storeSahbState ==
                                  RequestState.loaded) {
                                NavigateUtil().navigateUp(context);
                                NavigateUtil().navigateUp(context);
                                NavigateUtil().navigateUp(context);
                              } else if (state.storeSahbState ==
                                  RequestState.loading) {
                                NavigateUtil().navigateUp(context);
                              }
                            },
                            child: SahbButton(
                              onClick: () {
                                showSahbDialog(
                                    context: context,
                                    label: store.totalWeight != '0.000' ?
                                    AppStrings.addTonsDialogLabel :
                                    AppStrings.addBagsDialogLabel,
                                    action: (tons) {
                                      BlocProvider.of<ClientsBloc>(context)
                                          .add(
                                          SahbStoreEvent(
                                              store.id ?? -1,
                                              store.customerId ?? -1,
                                              num.parse(tons)
                                          ));
                                    }
                                );
                              },
                            ),
                          ))
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
