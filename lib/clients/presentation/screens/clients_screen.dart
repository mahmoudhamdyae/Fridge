import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../components/add_client_button.dart';
import '../components/client_details_button.dart';

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddClientButton(),
                    ClientDetailsButton()
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                )
              ],
            ),
          ),
        )
    );
  }
}
