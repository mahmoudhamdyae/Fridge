import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class UnitWeightFormField extends StatelessWidget {

  final TextEditingController unitWeightController;
  const UnitWeightFormField({
    super.key,
    required this.unitWeightController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: '',
      ),
      controller: unitWeightController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}