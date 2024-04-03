import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class TypeFormField extends StatelessWidget {

  final TextEditingController typeController;
  const TypeFormField({
    super.key,
    required this.typeController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.expensesScreenTypeHint,
      ),
      controller: typeController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}