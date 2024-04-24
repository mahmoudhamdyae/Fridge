import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/utils/validate_operations.dart';
import '../../../domain/entities/contact.dart';

class ClientPhoneFormField extends StatefulWidget {

  final TextEditingController clientNameController;
  final TextEditingController clientPhoneController;
  final List<CustomContact> customContacts;

  const ClientPhoneFormField({
    super.key,
    required this.clientNameController,
    required this.clientPhoneController,
    required this.customContacts,
  });

  @override
  State<ClientPhoneFormField> createState() => _ClientPhoneFormFieldState();
}

class _ClientPhoneFormFieldState extends State<ClientPhoneFormField> {
  List<String> names = [];
  List<String> phones = [];
  late final List<CustomContact> customContacts;

  String selectedName = AppStrings.addClientScreenClientPhoneLabel;

  @override
  void initState() {
    super.initState();
    customContacts = widget.customContacts;
  }


  @override
  Widget build(BuildContext context) {
    return TypeAheadField<CustomContact>(
      controller: widget.clientPhoneController,
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
              label: AppStrings.addClientScreenClientPhoneLabel,
              // suffixIcon: Icons.phone,
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
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
        widget.clientPhoneController.text = contact.phone;
        if (widget.clientNameController.text.isEmpty) {
          widget.clientNameController.text = contact.name;
        }
      },
    );
  }

}
