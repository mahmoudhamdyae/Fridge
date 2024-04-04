import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/utils/validate_operations.dart';

class ProductPriceFormField extends StatelessWidget {

  final TextEditingController productPriceController;
  const ProductPriceFormField({
    super.key,
    required this.productPriceController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: '',
      ),
      controller: productPriceController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}