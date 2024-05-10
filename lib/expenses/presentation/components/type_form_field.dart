import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/validate_operations.dart';

class TypeFormField extends StatefulWidget {

  final List<String> names;
  final Function(String) chosenType;
  final String selectedName;

  const TypeFormField({
    super.key,
    required this.names,
    required this.chosenType,
    this.selectedName = AppStrings.expensesScreenTypeHint
  });

  @override
  State<TypeFormField> createState() => _TypeFormFieldState();
}

class _TypeFormFieldState extends State<TypeFormField> {

  late String selectedName;

  @override
  void initState() {
    super.initState();
    selectedName = widget.selectedName;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) => ValidateOperations.normalValidation(
            selectedName == AppStrings.expensesScreenTypeHint ? null : selectedName
        ),
        decoration: getFilledTextFieldDecoration(
            hint: AppStrings.expensesScreenTypeHint
        ),
        isExpanded: true,
        value: selectedName,
        onChanged: (newValue) {
          setState(() {
            selectedName = newValue ?? AppStrings.expensesScreenTypeHint;
            widget.chosenType(newValue ?? AppStrings.expensesScreenTypeHint);
          });
        },
        style: getSmallStyle(),
        items: widget.names.map((name) {
          return DropdownMenuItem(
            value: name,
            child: Text(
              name,
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