import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';
import '../bloc/settings_bloc.dart';

class LargeBagsFormField extends StatelessWidget {

  final TextEditingController largeBagsController;
  const LargeBagsFormField({
    super.key,
    required this.largeBagsController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.settingsScreenLargeBagHint,
      ),
      onChanged: (value) {
        BlocProvider.of<SettingsBloc>(context).add(UpdatePriceEvent(double.parse(value)));
      },
      controller: largeBagsController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}