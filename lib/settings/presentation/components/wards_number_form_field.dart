import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/settings/presentation/bloc/settings_bloc.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class WardsNumberFormField extends StatelessWidget {

  final TextEditingController wardsNumberController;
  const WardsNumberFormField({
    super.key,
    required this.wardsNumberController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.settingsScreenWardsNumberHint,
      ),
      onChanged: (value) {
        BlocProvider.of<SettingsBloc>(context).add(UpdateWardNumberEvent(int.parse(value)));
      },
      controller: wardsNumberController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}