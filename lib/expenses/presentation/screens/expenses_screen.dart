import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/settings_button.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/expenses/domain/entities/expense_type.dart';
import 'package:fridge/expenses/domain/entities/expenses_response.dart';
import 'package:fridge/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fridge/expenses/presentation/screens/add_expense_screen.dart';
import 'package:fridge/expenses/presentation/screens/expenses_settings_screen.dart';

import '../../../core/components/decorations.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {

  late final ExpensesBloc bloc;
  String selectedChip = AppStrings.expensesScreenAll;
  double totalPrice = 0;

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
        listenWhen: (previous, current) =>
        current is StoreExpenseErrorState ||
            current is StoreExpenseSuccessState,
        listener: (context, state) {
          if (state is StoreExpenseErrorState) {
            NavigateUtil().navigateUp(context);
            showError(context, state.errorMessage, () {});
          } else if (state is StoreExpenseSuccessState) {
            NavigateUtil().navigateUp(context);
            NavigateUtil().navigateUp(context);
            BlocProvider.of<ExpensesBloc>(context).add(GetExpensesEvent());
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
              // Settings Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    child: SettingsButton(onTab: () {
                      NavigateUtil().navigateToScreen(
                          context,
                          BlocProvider.value(
                              value: instance<ExpensesBloc>(),
                              child: const ExpensesSettingsScreen()
                          )
                      );
                    }),
                  ),
                ],
              ),
              BlocBuilder<ExpensesBloc, ExpensesState>(
                buildWhen: (previous, current) =>
                current is GetExpensesLoadingState ||
                    current is GetExpensesErrorState ||
                    current is GetExpensesLoadedState,
                  builder: (BuildContext context, state) {
                  List<ExpenseType> types = state.types;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: buildList(types),
                    ),
                  );
                  }
              ),
              16.ph,
              // First Row of the table
              Row(
                children: [
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabDate,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                          fontSize: 14.0,
                            color: AppColors.colorRamps3
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabProductType,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0,
                            color: AppColors.colorRamps3
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabDetails,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0,
                            color: AppColors.colorRamps3
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        AppStrings.detailsTabPrice,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                            fontSize: 14.0,
                          color: AppColors.colorRamps3
                        ),
                      )
                  ),
                ],
              ),
              16.ph,
              BlocBuilder<ExpensesBloc, ExpensesState>(
                buildWhen: (previous, current) =>
                current is GetExpensesLoadingState ||
                current is GetExpensesErrorState ||
                current is GetExpensesLoadedState,
                builder: (BuildContext context, state) {
                if (state is GetExpensesLoadingState) {
                  return const LoadingScreen();
                } else if (state is GetExpensesErrorState) {
                  return ErrorScreen(error: state.errorMessage);
                } else if (state is GetExpensesLoadedState) {
                  List<ExpensesResponse> allExpenses = state.expenses;
                  List<ExpensesResponse> expenses =
                  selectedChip == AppStrings.expensesScreenAll ? allExpenses
                      :
                  allExpenses.where((element) =>
                      element.title == selectedChip
                  ).toList();
                  totalPrice = 0;
                  for (var element in expenses) {
                    totalPrice += double.parse(element.amount ?? '0');
                  }
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: expenses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: const EdgeInsets.all(16.0),
                              color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        expenses[index].date ?? '',
                                        textAlign: TextAlign.center,
                                        style: getSmallStyle(fontSize: 10.0),
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        expenses[index].title ?? '',
                                        textAlign: TextAlign.center,
                                        style: getSmallStyle(fontSize: 10.0),
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        expenses[index].description ?? '',
                                        textAlign: TextAlign.center,
                                        style: getSmallStyle(fontSize: 10.0),
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        '${expenses[index].amount ?? ''} ${AppStrings.egp}',
                                        textAlign: TextAlign.center,
                                        style: getSmallStyle(fontSize: 10.0),
                                      )
                                  ),
                                ],
                              )
                          );
                        },
                      ),
                      16.ph,
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(child: Container()),
                          Expanded(child: Text(
                            AppStrings.expensesScreenTotal,
                            textAlign: TextAlign.center,
                            style: getSmallStyle(
                              color: AppColors.colorRamps2
                            ),
                          )),
                          Expanded(child: Text(
                            '$totalPrice ${AppStrings.egp}',
                            textAlign: TextAlign.center,
                            style: getSmallStyle(
                                color: AppColors.colorRamps3
                            ),
                          )),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },)
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> buildList(List<ExpenseType> types) {
    Widget widget = InkWell(
      onTap: () {
        setState(() {
          selectedChip = AppStrings.expensesScreenAll;
        });
      },
      child: RawChip(
        checkmarkColor: AppColors.white,
        labelStyle: getSmallStyle(
          color: selectedChip == AppStrings.expensesScreenAll ? AppColors.white : AppColors.black,
        ),
        selectedColor: AppColors.colorRamps3,
        label: const Text(
          AppStrings.expensesScreenAll,
        ), selected: selectedChip == AppStrings.expensesScreenAll,
      ),
    );
    List<Widget> x = types.map((i) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedChip = i.name ?? AppStrings.expensesScreenAll;
          });
        },
        child: RawChip(
          checkmarkColor: AppColors.white,
          labelStyle: getSmallStyle(
            color: i.name == selectedChip ? AppColors.white : AppColors.black,
          ),
          selectedColor: AppColors.colorRamps3,
          label: Text(
            '${i.name}',
            // style: getSmallStyle(),
          ), selected: i.name == selectedChip,
        ),
      ),
    )).toList();
    List<Widget> widgets = [];
    widgets.add(widget);
    for (var element in x) {
      widgets.add(element);
    }
    return widgets;
  }
}
