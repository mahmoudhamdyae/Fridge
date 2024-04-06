import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/expenses/presentation/components/date_form_field.dart';
import 'package:fridge/expenses/presentation/components/details_form_field.dart';
import 'package:fridge/expenses/presentation/components/price_form_field.dart';
import 'package:fridge/expenses/presentation/components/register_button.dart';

import '../../../core/components/decorations.dart';
import '../components/type_form_field.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                    Text(
                      AppStrings.expensesScreenDateLabel,
                      style: getSmallStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: 18,
                      ),
                    ),
                    16.pw,
                    Expanded(
                        child: DateFormField(
                      dateController: dateController,
                    )),
                  ],
                ),
                16.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.expensesScreenTypeLabel,
                      style: getSmallStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: 18,
                      ),
                    ),
                    16.pw,
                    Expanded(
                        child: TypeFormField(
                      typeController: typeController,
                    )),
                  ],
                ),
                16.ph,
                Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.expensesScreenDetailsLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                            fontSize: 18,
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
                    Text(
                      AppStrings.expensesScreenPriceLabel,
                      style: getSmallStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: 18,
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
                RegisterButton(onTap: () {
                  if (validate != null && validate == true) {
                    showLoading(context);
                    BlocProvider.of<ExpensesBloc>(context).add(
                        StoreExpensesEvent(
                            typeController.text,
                            dateController.text,
                            detailsController.text,
                            priceController.text));
                  }
                }),
                const BackButton2(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
