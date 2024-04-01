import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class PackagingTypeFormField extends StatefulWidget {

  final Function(String) chosenPackage;
  const PackagingTypeFormField({
    super.key,
    required this.chosenPackage,
  });

  @override
  State<PackagingTypeFormField> createState() => _PackagingTypeFormFieldState();
}

class _PackagingTypeFormFieldState extends State<PackagingTypeFormField> {

  String text = AppStrings.settingsScreenPackagingTypeHint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) => ValidateOperations.normalValidation(text == AppStrings.settingsScreenPackagingTypeHint ? null : text),
        decoration: getFilledTextFieldDecoration(hint: AppStrings.settingsScreenPackagingTypeHint),
        isExpanded: true,
        value: AppStrings.settingsScreenPackagingTypeHint,
        onChanged: (newValue) {
          setState(() {
            text = newValue ?? AppStrings.settingsScreenPackagingTypeHint;
          });
          widget.chosenPackage(newValue ?? AppStrings.settingsScreenPackagingTypeHint);
        },
        style: getSmallStyle(),
        items: [
          AppStrings.settingsScreenPackagingTypeHint,
          AppStrings.addClientScreenPackagingType1,
          AppStrings.addClientScreenPackagingType2,
        ].map((unit) {
          return DropdownMenuItem(
            value: unit,
            child: Text(
              unit,
              style: getSmallStyle(
                color: const Color(0xff797979),
                fontSize: 14.0,
              ),
            ),
          );
        }).toList(),
      );
  }
}