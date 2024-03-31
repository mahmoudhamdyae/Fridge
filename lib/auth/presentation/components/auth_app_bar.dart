import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: AppColors.colorRamps2,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  )
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: context.dynamicWidth(0.09),
                    bottom: context.dynamicHeight(0.035),
                ),
                child: Text(
                  AppStrings.loginScreenTitle,
                  style: getLargeStyle(
                    fontSize: 24.0,
                    color: AppColors.white
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
