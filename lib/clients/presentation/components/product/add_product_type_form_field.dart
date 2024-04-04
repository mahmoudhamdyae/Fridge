import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/utils/validate_operations.dart';

class AddProductTypeFormField extends StatefulWidget {

  final Function(String) chosenType;
  const AddProductTypeFormField({
    super.key,
    required this.chosenType,
  });

  @override
  State<AddProductTypeFormField> createState() => _AddProductTypeFormFieldState();
}

class _AddProductTypeFormFieldState extends State<AddProductTypeFormField> {

  String text = AppStrings.addClientScreenProductTypeHint;
  List<String> productTypes = [AppStrings.addClientScreenProductTypeHint];

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<ClientsBloc>(context).state;
    for (var element in state.remoteProductsTypes) {
      productTypes.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        validator: (value) => ValidateOperations.normalValidation(
            text == AppStrings.addClientScreenProductTypeHint ? null : text
        ),
        decoration: getFilledTextFieldDecoration(
            hint: AppStrings.addClientScreenProductTypeHint
        ),
        isExpanded: true,
        value: AppStrings.addClientScreenProductTypeHint,
        onChanged: (newValue) {
          setState(() {
            text = newValue ?? AppStrings.addClientScreenProductTypeHint;
          });
          widget.chosenType(newValue ?? AppStrings.addClientScreenProductTypeHint);
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