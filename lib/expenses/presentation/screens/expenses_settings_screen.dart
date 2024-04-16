import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/expenses/domain/entities/expense_type.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../bloc/expenses_bloc.dart';

class ExpensesSettingsScreen extends StatelessWidget {
  const ExpensesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(canNavigateUp: true,),
                BlocConsumer<ExpensesBloc, ExpensesState>(
                  listener: (BuildContext context, ExpensesState state) {
                    if (state is StoreExpenseTypeLoadingState || state is DelExpenseTypeLoadingState) {
                      showLoading(context);
                    } else if (state is StoreExpenseTypeErrorState) {
                      NavigateUtil().navigateUp(context);
                      showError(context, state.errorMessage, () {});
                    } else if (state is DelExpenseTypeErrorState) {
                      NavigateUtil().navigateUp(context);
                      showError(context, state.errorMessage, () {});
                    } else if (state is StoreExpenseTypeSuccessState || state is DelExpenseTypeSuccessState) {
                      BlocProvider.of<ExpensesBloc>(context).add(GetExpensesTypesEvent());
                      NavigateUtil().navigateUp(context);
                    }
                  },
                  // buildWhen: (previous, current) => current.types.isNotEmpty,
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.types.length,
                      itemBuilder: (BuildContext context, int index) {
                        ExpenseType type = state.types[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Card(
                            color: AppColors.white,
                              child: ListTile(
                                  title: Text(
                                    type.name ?? '',
                                    style: getSmallStyle(),
                                  ),
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ExpensesBloc>(context).add(DelExpenseTypeEvent(type.id ?? -1));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}
