import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/utils/validate_operations.dart';

class SizeFormField extends StatelessWidget {

  final TextEditingController sizeController;
  const SizeFormField({
    super.key,
    required this.sizeController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(hint: ''),
      controller: sizeController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}