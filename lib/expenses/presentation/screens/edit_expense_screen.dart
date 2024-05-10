import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/expenses/domain/entities/expense_type.dart';
import 'package:fridge/expenses/domain/entities/expenses_response.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/components/dialogs/loading_dialog.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../ward/presentation/components/back_button.dart';
import '../bloc/expenses_bloc.dart';
import '../components/details_form_field.dart';
import '../components/price_form_field.dart';
import '../components/type_form_field.dart';

class EditExpenseScreen extends StatefulWidget {
  final ExpensesResponse expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ExpenseType? chosenType;
  late TextEditingController detailsController;
  late TextEditingController priceController;

  bool? get validate => _formKey.currentState?.validate();

  @override
  void initState() {
    super.initState();
    chosenType = ExpenseType(
        id: widget.expense.expenseTypeId,
        name: widget.expense.title,
        fridgeId: -1);
    detailsController =
        TextEditingController(text: widget.expense.description ?? '');
    priceController = TextEditingController(text: widget.expense.amount ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    detailsController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: context.height,
          padding: getMainPadding(context),
          decoration: getMainDecoration(),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(
                  canNavigateUp: true,
                ),
                Text(
                  AppStrings.expensesScreenTitle,
                  style: getLargeStyle(fontSize: 20),
                ),
                32.ph,
                Row(
                  children: [
                    SizedBox(
                      width: 65,
                      child: Text(
                        AppStrings.expensesScreenTypeLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    16.pw,
                    Expanded(child: BlocBuilder<ExpensesBloc, ExpensesState>(
                      builder: (context, state) {
                        List<ExpenseType> types = state.types;
                        List<String> names = [
                          AppStrings.expensesScreenTypeHint
                        ];
                        for (var type in types) {
                          names.add(type.name ?? '');
                        }
                        return TypeFormField(
                          names: names,
                          chosenType: (chosenValue) {
                            chosenType = types.firstWhere(
                                (element) => element.name == chosenValue);
                          },
                          selectedName: chosenType?.name ??
                              AppStrings.expensesScreenTypeHint,
                        );
                      },
                    )),
                  ],
                ),
                16.ph,
                Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 65,
                          child: Text(
                            AppStrings.expensesScreenDetailsLabel,
                            style: getSmallStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        16.pw,
                        Expanded(
                            child: DetailsFormField(
                          detailsController: detailsController,
                        )),
                      ],
                    ),
                    Positioned(
                        left: 4,
                        bottom: 4,
                        child: Image.asset(
                          AppAssets.write,
                          height: 20,
                          width: 20,
                        ))
                  ],
                ),
                16.ph,
                Row(
                  children: [
                    SizedBox(
                      width: 65,
                      child: Text(
                        AppStrings.expensesScreenPriceLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    16.pw,
                    Expanded(
                        child: PriceFormField(
                      priceController: priceController,
                    )),
                  ],
                ),
                32.ph,
                InkWell(
                  onTap: () {
                    if (validate != null && validate == true) {
                      showLoading(context);
                      BlocProvider.of<ExpensesBloc>(context).add(
                          EditExpenseEvent(
                              widget.expense.id.toString(),
                              chosenType?.id ?? -1,
                              detailsController.text,
                              priceController.text));
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Color(0xff193263)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        AppStrings.expensesScreenEditButton,
                        textAlign: TextAlign.center,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const BackButton2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
