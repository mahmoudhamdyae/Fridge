import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/utils/validate_operations.dart';

class AddPackagingTypeFormField extends StatefulWidget {

  final Function(String) chosenType;
  const AddPackagingTypeFormField({
    super.key,
    required this.chosenType,
  });

  @override
  State<AddPackagingTypeFormField> createState() => _AddProductTypeFormFieldState();
}

class _AddProductTypeFormFieldState extends State<AddPackagingTypeFormField> {

  String text = AppStrings.addClientScreenPackagingTypeHint;
  List<String> productTypes = [AppStrings.addClientScreenPackagingTypeHint];

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<ClientsBloc>(context).state;
    for (var element in state.remotePackagingTypes) {
      productTypes.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) => ValidateOperations.normalValidation(
            text == AppStrings.addClientScreenPackagingTypeHint ? null : text
        ),
        decoration: getFilledTextFieldDecoration(
            hint: AppStrings.addClientScreenPackagingTypeHint
        ),
        isExpanded: true,
        value: AppStrings.addClientScreenPackagingTypeHint,
        onChanged: (newValue) {
          setState(() {
            text = newValue ?? AppStrings.addClientScreenPackagingTypeHint;
          });
          widget.chosenType(newValue ?? AppStrings.addClientScreenPackagingTypeHint);
        },
        style: getSmallStyle(),
        items: productTypes.map((unit) {
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