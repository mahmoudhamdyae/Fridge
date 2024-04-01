import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class WardsNumberFormField extends StatelessWidget {

  final TextEditingController wardsNumberController;
  const WardsNumberFormField({
    super.key,
    required this.wardsNumberController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.settingsScreenWardsNumberHint,
      ),
      controller: wardsNumberController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}