import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/utils/validate_operations.dart';
import '../bloc/settings_bloc.dart';

class ProductTypeFormField extends StatelessWidget {

  final List<TextEditingController> productTypeController;
  const ProductTypeFormField({
    super.key,
    required this.productTypeController,
  });


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productTypeController.length,
      itemBuilder: (BuildContext context, int index) {
        return TextFormField(
          decoration: getFilledTextFieldDecoration(
            hint: AppStrings.settingsScreenProductTypeHint,
          ),
          onChanged: (value) {
            List<String> products = [];
            for (var element in productTypeController) {
              products.add(element.text);
            }
            BlocProvider.of<SettingsBloc>(context).add(UpdateProductTypeEvent(products));
          },
          controller: productTypeController[index],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (value) => ValidateOperations.normalValidation(value),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return 8.ph;
    },
    );
  }
}