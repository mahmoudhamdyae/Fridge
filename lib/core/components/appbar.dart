import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../auth/presentation/bloc/auth_bloc.dart';
import 'custom_text.dart';

class CustomAppBar extends AppBar {

  final String text;

  CustomAppBar(
      this.text, {
        super.key,
        this.isHome = false,
      });

  final bool isHome;

  @override
  State<AppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.appLogo,
            height: context.dynamicHeight(0.03),
            width: context.dynamicWidth(0.06),
          ),
          7.pw,
          CustomText(
            AppStrings.appName,
            textStyle: context.textTheme.headlineSmall,
          ),
        ],
      ),
      actions: [
        widget.isHome
            ? IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(SignOutRequested());
            NavigateUtil().navigateToScreen(context, const LoginScreen());
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: AppColors.black,
          ),
        )
            : const SizedBox.shrink(),
        10.pw,
      ],
    );
  }
}