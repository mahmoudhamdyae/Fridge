import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/utils/validate_operations.dart';

class ClientPhoneFormField extends StatelessWidget {

  final TextEditingController clientPhoneController;
  const ClientPhoneFormField({
    super.key,
    required this.clientPhoneController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecorationWithLabel(
        label: AppStrings.addClientScreenClientPhoneLabel,
      ),
      controller: clientPhoneController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}