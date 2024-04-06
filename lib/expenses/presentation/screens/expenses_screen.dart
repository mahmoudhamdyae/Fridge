import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fridge/expenses/presentation/screens/add_expense_screen.dart';

import '../../../core/components/decorations.dart';


class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {

  late final ExpensesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ExpensesBloc>();
    bloc.add(GetExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavigateUtil().navigateToScreen(context, BlocProvider.value(value: instance<ExpensesBloc>(),
              child: const AddExpenseScreen()));
            },
            backgroundColor: AppColors.colorRamps3,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
      body: BlocListener<ExpensesBloc, ExpensesState>(
        listener: (context, state) {
          if (state.storeExpensesState == RequestState.error) {
            NavigateUtil().navigateUp(context);
            showError(context, state.storeExpensesErrorMessage, () {});
          } else if (state.storeExpensesState == RequestState.loaded) {
            NavigateUtil().navigateUp(context);
            NavigateUtil().navigateUp(context);
          }
        },
        child: Container(
          height: context.height,
          decoration: getMainDecoration(),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              const MainAppBar(canNavigateUp: true,),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabDate,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                          fontSize: 14.0
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabProductType,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabDetails,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabPrice,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0
                        ),
                      )
                  ),
                ],
              ),
              16.ph,
              BlocBuilder<ExpensesBloc, ExpensesState>(
                builder: (BuildContext context, state) {
                if (state.getExpensesState == RequestState.loading) {
                  return const LoadingScreen();
                } else if (state.getExpensesState == RequestState.error) {
                  return ErrorScreen(error: state.getExpensesErrorMessage);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.expenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                  state.expenses[index].date ?? '',
                                  textAlign: TextAlign.center,
                                  style: getSmallStyle(fontSize: 10.0),
                                )
                            ),
                            Expanded(
                                child: Text(
                                  state.expenses[index].title ?? '',
                                  textAlign: TextAlign.center,
                                  style: getSmallStyle(fontSize: 10.0),
                                )
                            ),
                            Expanded(
                                child: Text(
                                  state.expenses[index].description ?? '',
                                  textAlign: TextAlign.center,
                                  style: getSmallStyle(fontSize: 10.0),
                                )
                            ),
                            Expanded(
                                child: Text(
                                  '${state.expenses[index].amount ?? ''} ${AppStrings.egp}',
                                  textAlign: TextAlign.center,
                                  style: getSmallStyle(fontSize: 10.0),
                                )
                            ),
                          ],
                        )
                    );
                  },
                );
              },)
            ],
          ),
        ),
      ),
    ));
  }
}
