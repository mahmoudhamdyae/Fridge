import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/clients/presentation/screens/add_new_client_screen.dart';

import '../../../core/resources/styles_manager.dart';

class AddClientButton extends StatelessWidget {

  final Function onClick;
  const AddClientButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: 139,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.clientsScreenAddClientButton,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontSize: 14.0,
              color: const Color(0xff193263),
            ),
          ),
        ),
      ),
    );
  }
}
