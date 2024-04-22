import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../../core/components/decorations.dart';
import '../../domain/entities/contact.dart';

class GetContactScreen extends StatefulWidget {

  final List<CustomContact> customContacts;
  final Function(String, String) onSelect;

  const GetContactScreen({
    super.key,
    required this.customContacts,
    required this.onSelect
  });

  @override
  State<GetContactScreen> createState() => _GetContactScreenState();
}

class _GetContactScreenState extends State<GetContactScreen> {

  @override
  void initState() {
    super.initState();
    if (widget.customContacts.isEmpty) getContacts();
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
          debugPrint('Contact Image: $thumbnail');
          widget.customContacts
              .add(CustomContact(name: customName, phone: customPhone, thumbnail: thumbnail));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: context.height,
          padding: getMainPadding(context),
          decoration: getMainDecoration(),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              const MainAppBar(canNavigateUp: true),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.customContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  CustomContact contact = widget.customContacts[index];
                  Uint8List? thumbnail = contact.thumbnail;
                  Image image = Image.memory(thumbnail ?? Uint8List(0));
                  return InkWell(
                    onTap: () {
                      widget.onSelect(contact.name, contact.phone);
                      NavigateUtil().navigateUp(context);
                    },
                    child: ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      leading: contact.thumbnail == null ? const SizedBox(
                        width: 20,
                        height: 20,
                      )
                          :
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: image,
                    )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
