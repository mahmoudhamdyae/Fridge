import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class NumberFormField extends StatelessWidget {

  final TextEditingController numberController;
  final TextEditingController unitWeightController;
  final TextEditingController totalWeightController;
  const NumberFormField({
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
        // if (
        // unitWeightController.text.isNotEmpty &&
        //     numberController.text.isNotEmpty
        // ) {
        //   totalWeightController.text =
        //       (int.parse(numberController.text) *
        //           int.parse(unitWeightController.text)).toString();
        // }

        // if (
        // totalWeightController.text.isNotEmpty &&
        //     numberController.text.isNotEmpty
        // ) {
        //   unitWeightController.text =
        //       (int.parse(totalWeightController.text) /
        //           int.parse(numberController.text)).toInt().toString();
        // }
      },
      controller: numberController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}