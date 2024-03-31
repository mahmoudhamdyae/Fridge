import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/components/text_form_field.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class PhoneFormField extends StatelessWidget {

  final TextEditingController phoneController;
  const PhoneFormField({
    super.key,
    required this.phoneController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
          hint: AppStrings.loginScreenPhoneHint,
      ),
      controller: phoneController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}