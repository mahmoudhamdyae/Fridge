import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../../core/components/decorations.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
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

  late List<CustomContact> filteredContacts;

  @override
  void initState() {
    super.initState();
    filteredContacts = widget.customContacts;
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
              const MainAppBar(
                canNavigateUp: true,
                title: AppStrings.addClientScreenChooseContact,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: getFilledTextFieldDecoration(
                      hint: AppStrings.addClientScreenSearchHint,
                      radius: 20.0,
                      prefixIcon: Icons.search,
                      textStyle: getSmallStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeightManager.medium,
                          color: AppColors.dark2
                      )
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty || value == '') {
                        filteredContacts = widget.customContacts;
                      } else {
                        filteredContacts = [];
                        for (var element in widget.customContacts) {
                          if (
                          element.name.toLowerCase().contains(value.toLowerCase()) ||
                          element.phone.toLowerCase().contains(value.toLowerCase())
                          ) {
                            filteredContacts.add(element);
                          }
                        }
                      }
                    });
                  },
                ),
              ),
              8.ph,
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: filteredContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  CustomContact contact = filteredContacts[index];
                  Uint8List? thumbnail = contact.thumbnail;
                  Widget image;
                  if (thumbnail == null) {
                    image = CircleAvatar(
                      backgroundColor: Color((Random().nextDouble() * 0xFFFFFF)
                          .toInt()).withOpacity(0.1),
                      child: Text(contact.name[0].toUpperCase()),
                    );
                  } else {
                    image = Image.memory(thumbnail);
                  }
                  return InkWell(
                    onTap: () {
                      widget.onSelect(contact.name, contact.phone);
                      NavigateUtil().navigateUp(context);
                    },
                    child: ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      leading: SizedBox(
                          width: 40,
                          height: 40,
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
