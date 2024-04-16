import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/data/models/client_invoice.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/components/print_button.dart';

import '../../../core/components/decorations.dart';

class ClientInvoiceScreen extends StatelessWidget {

  const ClientInvoiceScreen({super.key});

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
                32.ph,
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          NavigateUtil().navigateUp(context);
                        },
                        icon: const Icon(Icons.arrow_back)
                    ),
                    // 16.pw,
                    Text(
                      AppStrings.billScreenTitle,
                      style: getLargeStyle(
                          fontSize: 24.0
                      ),
                    ),
                  ],
                ),
                24.ph,
                BlocBuilder<ClientsBloc, ClientsState>(
                  buildWhen: (previousState, state) =>
                  state.getInvoiceState == RequestState.loading ||
                  state.getInvoiceState == RequestState.loaded ||
                  state.getInvoiceState == RequestState.error,
                  builder: (context, state) {
                    if (state.getInvoiceState == RequestState.loading) {
                      return const LoadingScreen();
                    } else if (state.getInvoiceState == RequestState.loading) {
                      return ErrorScreen(error: state.getClientInvoiceMessage);
                    } else if (state.getInvoiceState == RequestState.loaded) {
                      ClientInvoiceStores store = state.invoice.stores![0];
                      return ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
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
                                  Text(
                                    AppStrings.billScreenClientDate,
                                    style: getSmallStyle(),
                                  ),
                                  Text(
                                    '12/05/2024', // todo
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
                            children: [
                              Text(
                                state.invoice.name ?? '',
                                style: getLargeStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              4.pw,
                              Text(
                                '(${state.invoice.type})',
                                style: getSmallStyle(
                                    color: const Color(0xff5A5A5A)
                                ),
                              )
                            ],
                          ),
                          32.ph,
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
                          24.ph,
                          Row(
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
                          ),
                          24.ph,
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
                                    (store.quantity).toString(),
                                    style: getSmallStyle(
                                      color: const Color(0xff6B6B6B),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          24.ph,
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenStoreType,
                                style: getSmallStyle(),
                              ),
                              Text(
                                store.boxing ?? '',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          24.ph,
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenStorePlace,
                                style: getSmallStyle(),
                              ),
                              Text(
                                'ثلاجة 5',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          24.ph,
                          const Divider(
                            height: 1.0,
                            color: Color(0xffC3C3C3),
                          ),
                          16.ph,
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenPrice,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${store.unit} ${AppStrings.egp}',
                                style: getSmallStyle(),
                              )
                            ],
                          ),
                          16.ph,
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenTotalPrice,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${store.price} ${AppStrings.egp}',
                                style: getSmallStyle(),
                              )
                            ],
                          ),
                          24.ph,
                          PrintButton(onTap: () {}),
                          const BackButton2()
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}