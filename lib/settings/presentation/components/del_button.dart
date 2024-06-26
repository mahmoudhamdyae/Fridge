import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';

// todo delete button
class DelButton extends StatelessWidget {

  final Function onClick;
  const DelButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onClick(); },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            color: Color(0xffCFCFCF),
            shape: BoxShape.circle
        ),
        child: const Icon(
          Icons.delete,
          color: AppColors.white,
        ),
      ),
    );
  }
}