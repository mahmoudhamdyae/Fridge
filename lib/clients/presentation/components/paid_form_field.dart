import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class PaidFormField extends StatelessWidget {

  final TextEditingController paidController;
  const PaidFormField({
    super.key,
    required this.paidController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecorationWithLabel(
        label: AppStrings.addPaidDialogLabel,
      ),
      controller: paidController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}