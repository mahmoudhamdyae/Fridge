import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';

class AddButton extends StatelessWidget {

  final Function onClick;
  const AddButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onClick(); },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          shape: BoxShape.circle
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
