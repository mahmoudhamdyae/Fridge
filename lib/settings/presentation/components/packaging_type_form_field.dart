import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';

class PackagingTypeFormField extends StatelessWidget {

  final Function(String) chosenPackage;
  const PackagingTypeFormField({
    super.key,
    required this.chosenPackage,
  });


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: getFilledTextFieldDecoration(hint: AppStrings.settingsScreenPackagingTypeHint),
        isExpanded: true,
        value: AppStrings.settingsScreenPackagingTypeHint,
        onChanged: (newValue) {
          chosenPackage(newValue ?? AppStrings.settingsScreenPackagingTypeHint);
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