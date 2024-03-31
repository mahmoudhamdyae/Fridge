import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class AddressFormField extends StatelessWidget {

  final TextEditingController addressController;
  const AddressFormField({
    super.key,
    required this.addressController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.registerScreenAddressHint,
      ),
      controller: addressController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}