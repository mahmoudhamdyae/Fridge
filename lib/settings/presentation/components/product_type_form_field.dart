import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class ProductTypeFormField extends StatelessWidget {

  final List<TextEditingController> productTypeController;
  const ProductTypeFormField({
    super.key,
    required this.productTypeController,
  });


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container()/*TextFormField(
          decoration: getFilledTextFieldDecoration(
            hint: AppStrings.settingsScreenProductTypeHint,
          ),
          controller: productTypeController[index],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (value) => ValidateOperations.normalValidation(value),
        )*/;
      },
    );
  }
}