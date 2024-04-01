import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class FridgeNameFormField extends StatelessWidget {

  final TextEditingController fridgeNameController;
  const FridgeNameFormField({
    super.key,
    required this.fridgeNameController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.registerScreenFridgeNameHint,
      ),
      controller: fridgeNameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}