import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/utils/validate_operations.dart';

class DetailsFormField extends StatelessWidget {

  final TextEditingController detailsController;
  const DetailsFormField({
    super.key,
    required this.detailsController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(hint: ''),
      controller: detailsController,
      maxLines: 4,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}