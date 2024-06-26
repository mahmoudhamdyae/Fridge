import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/components/all_transactions_table.dart';
import 'package:fridge/clients/presentation/components/sahb_table.dart';
import 'package:fridge/clients/presentation/screens/clients_screen.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/components/dialogs/error_dialog.dart';
import '../../../core/components/dialogs/loading_dialog.dart';
import '../../../core/enums/request_state.dart';
import '../../../core/navigation/navigate_util.dart';
import '../bloc/clients_bloc.dart';
import '../components/add_paid_dialog.dart';

class AllTransactionsScreen extends StatefulWidget {

  final int amountPaid;
  final int amountRemain;
  final String clientName;
  final int clientId;

  const AllTransactionsScreen({
    super.key,
    required this.amountPaid,
    required this.amountRemain,
    required this.clientName,
    required this.clientId
  });

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {

  bool? isPaidShown;
  bool? isSahbShown;

  late ClientsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ClientsBloc>();
    bloc.add(GetAmountPaidEvent(widget.clientId));
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
                const MainAppBar(canNavigateUp: true,),
                Center(
                  child: Text(
                    widget.clientName,
                    style: getLargeStyle(
                      fontSize: 24
                    ),
                  ),
                ),
                16.ph,
                // المعاملات المالية
                InkWell(
                  onTap: () {
                    if (isPaidShown == null || isPaidShown == false) {
                      setState(() {
                        isPaidShown = true;
                      });
                    } else {
                      setState(() {
                        isPaidShown = null;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: AppColors.colorRamps3,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            BlocListener<ClientsBloc, ClientsState>(
                              listenWhen: (previous, current) =>
                              current.addPaidState == RequestState.error ||
                              current.addPaidState == RequestState.loaded,
                              listener: (context, state) {
                               if (state.addPaidState == RequestState.error) {
                                  NavigateUtil().navigateUp(context);
                                  showError(context, state.addPaidErrorMessage,
                                          () {});
                                } else if (state.addPaidState ==
                                    RequestState.loaded) {
                                  NavigateUtil().navigateAndClear(
                                      context, BlocProvider.value(
                                    value: instance<ClientsBloc>(),
                                    child: const ClientsScreen(),
                                  ));
                                }
                              },
                              child: IconButton(
                                  onPressed: () {
                                    showAddPaidDialog(
                                        context: context,
                                        action: (paid) {
                                          showLoading(context);
                                          BlocProvider.of<ClientsBloc>(context)
                                              .add(AddPaidEvent(paid, widget.clientId));
                                        });
                                  },
                                  icon: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: const BoxDecoration(
                                        color: AppColors.secondary,
                                        shape: BoxShape.circle
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                      size: 24,
                                    ),
                                  )
                              ),
                            ),
                            8.pw,
                            Text(
                              AppStrings.addClientScreenShowAllTransactions1,
                              style: getSmallStyle(
                                color: AppColors.white
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          isPaidShown == true ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
                16.ph,
                isPaidShown == true ? BlocBuilder<ClientsBloc, ClientsState>(
                  buildWhen: (previous, current) =>
                  current.getAmountPaidState == RequestState.loading ||
                  current.getAmountPaidState == RequestState.error ||
                  current.getAmountPaidState == RequestState.loaded,
                  builder: (BuildContext context, state) {
                    if (state.getAmountPaidState == RequestState.loading) {
                      return const LoadingScreen();
                    } else if (state.getAmountPaidState == RequestState.error) {
                      return ErrorScreen(error: state.getAmountPaidErrorMessage);
                    }
                    return AllTransactionsTable(
                      paid: widget.amountPaid,
                      remain: widget.amountRemain,
                      amounts: state.amounts,
                    );
                  },
                ) : Container(),
                isPaidShown == true ? 16.ph : 0.ph,
                // تاريخ السحب
                InkWell(
                  onTap: () {
                    if (isSahbShown == null || isSahbShown == false) {
                      setState(() {
                        isSahbShown = true;
                      });
                    } else {
                      setState(() {
                        isSahbShown = null;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: AppColors.colorRamps3,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          child: Text(
                            AppStrings.addClientScreenShowAllTransactions2,
                            style: getSmallStyle(
                                color: AppColors.white
                            ),
                          ),
                        ),
                        Icon(
                          isSahbShown == true ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
                16.ph,
                isSahbShown == true ?
                BlocBuilder<ClientsBloc, ClientsState>(
                  buildWhen: (previous, current) =>
                  current.getAmountPaidState == RequestState.loading ||
                      current.getAmountPaidState == RequestState.error ||
                      current.getAmountPaidState == RequestState.loaded,
                  builder: (BuildContext context, state) {
                    if (state.getAmountPaidState == RequestState.loading) {
                      return const LoadingScreen();
                    } else if (state.getAmountPaidState == RequestState.error) {
                      return ErrorScreen(error: state.getAmountPaidErrorMessage);
                    }
                    return SahbTable(
                      amounts: state.amounts,
                    );
                  },
                ) : Container(),
                isSahbShown == true ? 16.ph : 16.ph,
              ],
            ),
          ),
        )
    );
  }
}
