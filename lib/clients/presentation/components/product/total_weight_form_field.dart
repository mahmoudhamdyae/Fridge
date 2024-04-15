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
        if (
        numberController.text.isNotEmpty &&
            unitWeightController.text.isEmpty
        ) {
          unitWeightController.text =
              (int.parse(totalWeightController.text) ~/
                  int.parse(numberController.text)).toString();
        } else if (
        numberController.text.isEmpty &&
            unitWeightController.text.isNotEmpty
        ) {
          numberController.text =
              (int.parse(totalWeightController.text) ~/
                  int.parse(unitWeightController.text)).toString();
        }
      },
      controller: totalWeightController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}