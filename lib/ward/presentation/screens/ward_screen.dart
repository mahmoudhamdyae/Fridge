import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/components/decorations.dart';

class WardScreen extends StatelessWidget {
  const WardScreen({super.key});

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
            ),
          ),
        )
    );
  }
}
