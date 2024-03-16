import 'package:flutter/material.dart';

import '../../../core/components/text_form_field.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: passwordController,
      title: AppStrings.passwordTitle,
      hintText: AppStrings.passwordHint,
      isPassword: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}