import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/utils/validate_operations.dart';
import '../../../domain/entities/contact.dart';

class ClientNameFormField extends StatefulWidget {

  final TextEditingController clientNameController;
  final TextEditingController clientPhoneController;

  final List<CustomContact> customContacts;

  const ClientNameFormField({
    super.key,
    required this.clientNameController,
    required this.clientPhoneController,
    required this.customContacts,
  });

  @override
  State<ClientNameFormField> createState() => _ClientNameFormFieldState();
}

class _ClientNameFormFieldState extends State<ClientNameFormField> {

  List<String> names = [];
  List<String> phones = [];
  late final List<CustomContact> customContacts;

  @override
  void initState() {
    super.initState();
    customContacts = widget.customContacts;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<CustomContact>(
      controller: widget.clientNameController,
      suggestionsCallback: (search) {
        return customContacts.where((contact) {
          return contact.name.toLowerCase().contains(search.toLowerCase()) ||
              contact.phone.toLowerCase().contains(search.toLowerCase());
        }).toList();
      },
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: getFilledTextFieldDecorationWithLabel(
            label: AppStrings.addClientScreenClientNameLabel,
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (value) => ValidateOperations.normalValidation(value),
        );
      },
      itemBuilder: (context, customContact) {
        return ListTile(
          title: Text(customContact.name),
          subtitle: Text(customContact.phone),
        );
      },
      onSelected: (contact) {
        widget.clientNameController.text = contact.name;
        if (widget.clientPhoneController.text.isEmpty) {
          widget.clientPhoneController.text = contact.phone;
        }
      },
    );
  }
}