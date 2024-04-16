import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/utils/validate_operations.dart';

class AddTypeFormField extends StatelessWidget {

  final TextEditingController addTypeController;
  const AddTypeFormField({
    super.key,
    required this.addTypeController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(hint: AppStrings.expensesScreenAddTypeHint),
      controller: addTypeController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}