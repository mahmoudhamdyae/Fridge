import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fridge/clients/presentation/tabs/add_new_client_screen.dart';
import 'package:fridge/clients/presentation/tabs/add_product_screen.dart';
import 'package:fridge/clients/presentation/tabs/choose_ward_first_screen.dart';
import 'package:fridge/clients/presentation/tabs/choose_ward_second_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../domain/entities/contact.dart';

class AddClientTabsScreen extends StatefulWidget {

  final int currentTab;

  const AddClientTabsScreen({
    super.key,
    this.currentTab = 0,
  });

  @override
  State<AddClientTabsScreen> createState() => _AddClientTabsScreenState();
}

class _AddClientTabsScreenState extends State<AddClientTabsScreen> {

  late int currentTab;
  String productType = '';
  bool isTrader = true;

  List<CustomContact> customContacts = [];

  @override
  void initState() {
    super.initState();
    currentTab = widget.currentTab;
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
          debugPrint('Contact Image: $thumbnail');
          customContacts
              .add(CustomContact(name: customName, phone: customPhone, thumbnail: thumbnail));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: context.height,
          padding: getMainPadding(context),
          decoration: getMainDecoration(),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  const MainAppBar(),
                  IconButton(
                    onPressed: () {
                      if (currentTab == 0) {
                        NavigateUtil().navigateUp(context);
                      } else {
                        setState(() {
                          if (widget.currentTab == 1 && currentTab == 1) {
                            NavigateUtil().navigateUp(context);
                          } else {
                            currentTab--;
                          }
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff2D5AAF),
                    ),
                  )
                ],
              ),
              LinearProgressBar(
                maxSteps: 3,
                progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                currentStep: currentTab + 1,
                progressColor: AppColors.primary,
                backgroundColor: AppColors.grey,
              ),
              16.ph,
              currentTab == 0 ? AddNewClientScreen(moveForward: (isTrader) {
                setState(() {
                  currentTab = 1;
                  this.isTrader = isTrader;
                });
              }, customContacts: customContacts,)
                  :
                  currentTab == 1 ? AddProductScreen(
                    isTrader: isTrader,
                    moveForward: (productType) {
                      setState(() {
                        currentTab = 2;
                        this.productType = productType;
                      });
                      },
                  ) : currentTab == 2 ? ChooseWardFirstScreen(moveForward: () {
                        setState(() {
                          currentTab = 3;
                        });
                      },)
                          :
                      ChooseWardSecondScreen(productType: productType)
            ],
          ),
        ),
      ),
    );
  }
}
