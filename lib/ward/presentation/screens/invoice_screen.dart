import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/components/print_button.dart';

import '../../../core/components/decorations.dart';

class InvoiceScreen extends StatefulWidget {

  final int storeId;

  const InvoiceScreen({super.key, required this.storeId});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  late WardsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<WardsBloc>();
    bloc.add(GetInvoiceEvent(widget.storeId));
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
                BlocBuilder<WardsBloc, WardsState>(
                  buildWhen: (previousState, state) =>
                  state is GetInvoiceLoadingState ||
                      state is GetInvoiceErrorState ||
                      state is GetInvoiceLoadedState,
                  builder: (context, state) {
                    if (state is GetInvoiceLoadingState) {
                      return const LoadingScreen();
                    } else if (state is GetInvoiceErrorState) {
                      return ErrorScreen(error: state.errorMessage);
                    } else if (state is GetInvoiceLoadedState) {
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
                          Row(
                            children: [
                              Text(
                                state.invoice.customer?.name ?? '',
                                style: getLargeStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              4.pw,
                              Text(
                                '(${state.invoice.customer?.type})',
                                style: getSmallStyle(
                                    color: const Color(0xff5A5A5A)
                                ),
                              )
                            ],
                          ),
                          32.ph,
                          // المنتج
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenProduct,
                                style: getSmallStyle(),
                              ),
                              Text(
                                state.invoice.store?.product ?? '',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          state.invoice.store?.totalWeight != '0.000' ? 24.ph : 0.ph,
                          // الكمية
                          state.invoice.store?.totalWeight != '0.000' ? Row(
                            children: [
                              Text(
                                AppStrings.billScreenQuantity,
                                style: getSmallStyle(),
                              ),
                              Text(
                                '${state.invoice.store?.totalWeight} ${state.invoice.store?.unit}',
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ) : Container(),
                          24.ph,
                          // عدد الشكاير
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenNumber,
                                style: getSmallStyle(),
                              ),
                              Text(
                                (state.invoice.store?.quantity).toString(),
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
                              )
                            ],
                          ),
                          24.ph,
                          // رقم العنبر
                          Row(
                            children: [
                              Text(
                                AppStrings.billScreenWardsNumber,
                                style: getSmallStyle(),
                              ),
                              Text(
                                (state.invoice.store?.partName).toString(),
                                style: getSmallStyle(
                                  color: const Color(0xff6B6B6B),
                                ),
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
