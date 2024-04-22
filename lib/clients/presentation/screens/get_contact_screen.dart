import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../../core/components/decorations.dart';
import '../../domain/entities/contact.dart';

class GetContactScreen extends StatelessWidget {

  final List<CustomContact> customContacts;
  final Function(String, String) onSelect;

  const GetContactScreen({
    super.key,
    required this.customContacts,
    required this.onSelect
  });

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
                itemCount: customContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  CustomContact contact = customContacts[index];
                  return InkWell(
                    onTap: () {
                      onSelect(contact.name, contact.phone);
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
                          child: Image(image: MemoryImage(contact.thumbnail!))),
                    ),
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
