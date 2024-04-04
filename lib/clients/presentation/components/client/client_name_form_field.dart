import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/utils/validate_operations.dart';

class ClientNameFormField extends StatelessWidget {

  final TextEditingController clientNameController;
  const ClientNameFormField({
    super.key,
    required this.clientNameController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecorationWithLabel(
        label: AppStrings.addClientScreenClientNameLabel,
      ),
      controller: clientNameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}