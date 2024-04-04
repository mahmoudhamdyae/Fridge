import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/utils/validate_operations.dart';
import '../bloc/settings_bloc.dart';

class PackagingTypeFormField extends StatelessWidget {

  final List<TextEditingController> packagingTypeController;
  const PackagingTypeFormField({
    super.key,
    required this.packagingTypeController,
  });


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: packagingTypeController.length,
      itemBuilder: (BuildContext context, int index) {
        return TextFormField(
          decoration: getFilledTextFieldDecoration(
            hint: AppStrings.settingsScreenPackagingTypeHint,
          ),
          onChanged: (value) {
            List<String> boxing = [];
            for (var element in packagingTypeController) {
              boxing.add(element.text);
            }
            BlocProvider.of<SettingsBloc>(context).add(UpdatePackagingTypeEvent(boxing));
          },
          controller: packagingTypeController[index],
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