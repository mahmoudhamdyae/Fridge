import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fridge/clients/presentation/screens/get_contact_screen.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/utils/validate_operations.dart';
import '../../../domain/entities/contact.dart';

class ClientNameFormField extends StatefulWidget {

  final TextEditingController clientNameController;
  final TextEditingController clientPhoneController;

  const ClientNameFormField({
    super.key,
    required this.clientNameController,
    required this.clientPhoneController,
  });

  @override
  State<ClientNameFormField> createState() => _ClientNameFormFieldState();
}

class _ClientNameFormFieldState extends State<ClientNameFormField> {

  List<String> names = [];
  List<String> phones = [];
  List<CustomContact> customContacts = [];

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
          String customPhone = phone.number.replaceAll(' ', '');
          Uint8List? thumbnail = contact.thumbnail;
          debugPrint('Contact Name: $customName');
          debugPrint('Contact Phone: $customPhone');
          customContacts
              .add(CustomContact(name: customName, phone: customPhone, thumbnail: thumbnail));
        });
      }
    }
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
          decoration: InputDecoration(
            hintStyle: getSmallStyle(
              fontSize: 14.0,
              color: AppColors.dark2,
            ),
            prefixIconConstraints: const BoxConstraints(
              maxWidth: 32.0,
              minWidth: 32.0,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  NavigateUtil().navigateToScreen(
                      context,
                      GetContactScreen(
                        customContacts: customContacts,
                        onSelect: (String name, String phone) {
                          setState(() {
                            widget.clientNameController.text = name;
                            widget.clientPhoneController.text = phone;
                          });
                        },
                      )
                  );
                },
                icon: const Icon(
                    Icons.person_add_sharp,
                    color: Color(0xff545454)
                ),
            ),
            label: Text(
              AppStrings.addClientScreenClientNameLabel,
              style: getSmallStyle(
                  fontWeight: FontWeightManager.medium
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
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