import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class DateFormField extends StatelessWidget {

  final TextEditingController dateController;
  const DateFormField({
    super.key,
    required this.dateController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.expensesScreenDateHint,
      ),
      controller: dateController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}