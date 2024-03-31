import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class NameFormField extends StatelessWidget {

  final TextEditingController nameController;
  const NameFormField({
    super.key,
    required this.nameController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.registerScreenNameHint,
      ),
      controller: nameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}