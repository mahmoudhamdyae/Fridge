import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class PaidFormField extends StatelessWidget {

  final TextEditingController paidController;
  final String label;

  const PaidFormField({
    super.key,
    required this.paidController,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecorationWithLabel(
        label: label,
      ),
      controller: paidController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}