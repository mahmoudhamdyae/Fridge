import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class TotalWeightFormField extends StatelessWidget {

  final TextEditingController numberController;
  final TextEditingController unitWeightController;
  final TextEditingController totalWeightController;
  const TotalWeightFormField({
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
        double num = ((double.parse(totalWeightController.text) * 1000) /
            double.parse(numberController.text));
        int precision = 0;
        if (num * 10 - num.toInt() * 10 != 0) {
          precision = 2;
        } else {
          precision = 0;
        }
        unitWeightController.text = num.toStringAsFixed(precision);
      },
      controller: totalWeightController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}