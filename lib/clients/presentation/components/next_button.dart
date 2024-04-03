import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/font_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class NextButton extends StatelessWidget {

  final Function onClick;
  const NextButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onClick(); },
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xff193263)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.addClientScreenNextButton,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontWeight: FontWeightManager.medium,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
