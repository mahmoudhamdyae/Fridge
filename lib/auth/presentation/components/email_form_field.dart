import 'package:flutter/material.dart';

import '../../../core/components/text_form_field.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: emailController,
      title: AppStrings.emailTitle,
      hintText: AppStrings.emailHint,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) => ValidateOperations.emailValidation(value),
    );
  }
}