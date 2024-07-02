import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class AuthAppBar extends StatelessWidget {

  final String title;
  const AuthAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 120,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              16.pw,
              IconButton(
                  onPressed: () {
                    NavigateUtil().navigateUp(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.white,
                  )
              ),
              16.pw,
              Text(
                title,
                style: getLargeStyle(
                  fontSize: 24.0,
                  color: AppColors.white
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(
                    context.width * -.08, -36.0, 0.0
                ),
                child: Transform.rotate(
                  angle: -100.93,
                  child: Image.asset(
                    AppAssets.ellipse1,
                    width: 134,
                    height: 134,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                    context.width * -0.15, 0.0, 0.0
                ),
                child: Transform.rotate(
                  angle: -100.93,
                  child: Image.asset(
                    AppAssets.ellipse2,
                    width: 144,
                    height: 144,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
