import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../../core/components/decorations.dart';

class AddNewClientScreen extends StatelessWidget {
  const AddNewClientScreen({super.key});

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
                MainAppBar(),
                SecondaryAppBar(
                    text: AppStrings.addClientScreenAddClient,
                    icon: Icons.person_add_sharp
                )
              ],
            ),
          ),
        )
    );
  }
}
