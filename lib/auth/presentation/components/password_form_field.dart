import 'package:flutter/material.dart';

import '../../../core/components/text_form_field.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/utils/validate_operations.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.loginScreenPasswordHint,
      ),
      textInputAction: TextInputAction.next,
      obscureText: true,
      controller: passwordController,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}