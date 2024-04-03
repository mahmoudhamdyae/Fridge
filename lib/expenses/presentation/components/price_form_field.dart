import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/utils/validate_operations.dart';

class PriceFormField extends StatelessWidget {

  final TextEditingController priceController;
  const PriceFormField({
    super.key,
    required this.priceController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
          hint: AppStrings.expensesScreenPriceHint,
      ),
      controller: priceController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}