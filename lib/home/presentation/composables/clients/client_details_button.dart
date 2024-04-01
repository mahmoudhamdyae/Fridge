import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/styles_manager.dart';

class ClientDetailsButton extends StatelessWidget {
  const ClientDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
      },
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: 139,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff1F3A6F),
                Color(0xff3D6AC1),
              ],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.clientsScreenClientsDetails,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontSize: 14.0,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
