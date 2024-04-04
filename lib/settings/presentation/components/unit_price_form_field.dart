import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';
import '../bloc/settings_bloc.dart';

class UnitPriceFormField extends StatelessWidget {

  final TextEditingController unitPriceController;
  const UnitPriceFormField({
    super.key,
    required this.unitPriceController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.settingsScreenUnitPriceHint,
      ),
      onChanged: (value) {
        BlocProvider.of<SettingsBloc>(context).add(UpdatePriceEvent(int.parse(value)));
      },
      controller: unitPriceController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}