import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/utils/validate_operations.dart';
import '../../../domain/entities/contact.dart';

class ClientPhoneFormField extends StatefulWidget {

  final TextEditingController clientNameController;
  final TextEditingController clientPhoneController;

  const ClientPhoneFormField({
    super.key,
    required this.clientNameController,
    required this.clientPhoneController,
  });

  @override
  State<ClientPhoneFormField> createState() => _ClientPhoneFormFieldState();
}

class _ClientPhoneFormFieldState extends State<ClientPhoneFormField> {
  List<String> names = [];
  List<String> phones = [];
  List<CustomContact> customContacts = [];

  String selectedName = AppStrings.addClientScreenClientPhoneLabel;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      for (var element in contacts) {
        // Get contact with specific ID (fully fetched)
        Contact? contact = await FlutterContacts.getContact(element.id);
        contact?.phones.forEach((phone) {
          String customName = '${contact.name.first} ${contact.name.last}';
          String customPhone = phone.number;
          debugPrint('Contact Name: $customName');
          debugPrint('Contact Phone: $customPhone');
          customContacts
              .add(CustomContact(name: customName, phone: customPhone));
        });
      }
    }
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
              suffixIcon: Icons.phone),
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
