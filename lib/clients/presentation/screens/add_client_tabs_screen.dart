import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/tabs/add_new_client_screen.dart';
import 'package:fridge/clients/presentation/tabs/add_product_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';

class AddClientTabsScreen extends StatefulWidget {
  const AddClientTabsScreen({super.key});

  @override
  State<AddClientTabsScreen> createState() => _AddClientTabsScreenState();
}

class _AddClientTabsScreenState extends State<AddClientTabsScreen> {

  int currentTab = 0;

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
              const MainAppBar(
                canNavigateUp: true,
              ),
              currentTab == 0 ? const AddNewClientScreen()
                  :
                  currentTab == 1 ? const AddProductScreen()
                      : const AddProductScreen()
            ],
          ),
        ),
      ),
    );
  }
}
