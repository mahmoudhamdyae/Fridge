import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';
import '../bloc/settings_bloc.dart';

class SmallBagsFormField extends StatelessWidget {

  final TextEditingController smallBagsController;
  const SmallBagsFormField({
    super.key,
    required this.smallBagsController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecoration(
        hint: AppStrings.settingsScreenSmallBagHint,
      ),
      onChanged: (value) {
        BlocProvider.of<SettingsBloc>(context).add(UpdatePriceEvent(double.parse(value)));
      },
      controller: smallBagsController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}