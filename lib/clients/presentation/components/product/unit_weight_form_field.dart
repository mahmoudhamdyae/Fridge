import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class UnitWeightFormField extends StatelessWidget {

  final TextEditingController numberController;
  final TextEditingController unitWeightController;
  final TextEditingController totalWeightController;
  const UnitWeightFormField({
    super.key,
    required this.numberController,
    required this.unitWeightController,
    required this.totalWeightController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: '',
      ),
      onChanged: (value) {
        totalWeightController.text =
            ((int.parse(numberController.text) *
                double.parse(unitWeightController.text)) / 1000.0).toString();
      },
      controller: unitWeightController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}