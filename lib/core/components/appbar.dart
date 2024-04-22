import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import 'dialogs/del_account_dialog.dart';
import 'dialogs/sign_out_dialog.dart';

class MainAppBar extends StatelessWidget {

  final bool canNavigateUp;
  final bool isInHomeScreen;
  final String title;

  const MainAppBar({
    super.key,
    this.canNavigateUp = false,
    this.isInHomeScreen = false,
    this.title = AppStrings.wardsScreenTitle
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: context.width,
          height: context.dynamicHeight(.07),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: getLargeStyle(
              fontSize: 30.0,
              fontWeight: FontWeightManager.medium,
            ),
          ),
        ),
        canNavigateUp ? IconButton(
            onPressed: () {
              NavigateUtil().navigateUp(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff2D5AAF),
            ),
        ) : Container(),
        isInHomeScreen ?
        Positioned(
          left: 0,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    showSignOutDialog(context);
                  },
                  icon: const Icon(Icons.logout)
              ),
              PopupMenuButton<int>(
                onSelected: (item) => handleClick(item, context),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 0, child: Text(AppStrings.delAccountDialogTitle)),
                ],
              ),
            ],
          ),
        )
            :
        Container()
      ],
    );
  }

  void handleClick(int item, BuildContext context) {
    switch (item) {
      case 0:
        showDelAccountDialog(context);
        break;
      case 1:
        break;
    }
  }
}

class SecondaryAppBar extends StatelessWidget {

  final String text;
  final IconData icon;
  const SecondaryAppBar({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.dynamicHeight(.07),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff193263),
          ),
          16.pw,
          Text(
            text,
            textAlign: TextAlign.center,
            style: getLargeStyle(
              fontSize: 25.0,
              color: const Color(0xff193263),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryAppBarWithImage extends StatelessWidget {

  final String text;
  final String image;
  const SecondaryAppBarWithImage({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 25,
          height: 25,
        ),
        16.pw,
        Text(
          text,
          textAlign: TextAlign.center,
          style: getLargeStyle(
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }
}

class ThirdAppBar extends StatelessWidget {

  final String text;
  final String image;
  const ThirdAppBar({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 25,
          height: 25,
        ),
        16.pw,
        Text(
          text,
          textAlign: TextAlign.center,
          style: getSmallStyle(),
        ),
      ],
    );
  }
}
