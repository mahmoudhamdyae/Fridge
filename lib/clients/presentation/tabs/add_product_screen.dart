import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/components/cancel_button.dart';
import 'package:fridge/clients/presentation/components/next_button.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';

class AddProductScreen extends StatefulWidget {

  final Function moveForward;
  const AddProductScreen({super.key, required this.moveForward});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenAddProducts,
            image: AppAssets.person,
          ),
          32.ph,
          NextButton(onClick: () {
            widget.moveForward();
          }),
          const CancelButton(),
        ],
      ),
    );
  }
}
