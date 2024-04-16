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
                    icon: const Icon(Icons.arrow_back)),
                // 16.pw,
                Text(
                  AppStrings.billScreenTitle,
                  style: getLargeStyle(fontSize: 24.0),
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
                  List<ClientInvoiceStores> stores = state.invoice.stores ?? [];
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
                      Text(
                        state.invoice.name ?? '',
                        style: getLargeStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      32.ph,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: stores.length,
                        itemBuilder: (BuildContext context, int index) {
                          ClientInvoiceStores store = stores[index];
                          return InkWell(
                            onTap: () {
                              // todo navigate to ward
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                      ],
                                    ),
                                    24.ph,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                                  (store.quantity).toString(),
                                                  style: getSmallStyle(
                                                    color: const Color(0xff6B6B6B),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
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
                                          AppStrings.billScreenTotalPrice,
                                          style: getSmallStyle(),
                                        ),
                                        Text(
                                          '${store.price} ${AppStrings.egp}',
                                          style: getSmallStyle(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) { return 16.ph; },
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
    ));
  }
}
