import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

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
      autofillHints: const [AutofillHints.email],
      decoration: getFilledTextFieldDecoration(
          hint: AppStrings.loginScreenPhoneHint,
      ),
      controller: phoneController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}