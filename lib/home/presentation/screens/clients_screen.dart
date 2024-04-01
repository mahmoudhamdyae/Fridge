import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/home/presentation/composables/clients/add_client_button.dart';
import 'package:fridge/home/presentation/composables/clients/client_details_button.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

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
                const MainAppBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddClientButton(),
                    ClientDetailsButton()
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
