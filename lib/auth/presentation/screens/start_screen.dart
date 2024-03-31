import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/auth/presentation/screens/register_screen.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorRamps2,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              16.ph,
              Expanded(
                  child: Image.asset(
                    AppAssets.start,
                    width: double.infinity,
                  )
              ),
              Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.startScreenHello,
                          style: getLargeStyle(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          AppStrings.startScreenHelloDesc,
                          style: getSmallStyle(
                            color: AppColors.white,
                          ),
                        ),
                        32.ph,
                        FilledButton(
                          style: getFilledButtonStyle(
                            color: AppColors.white
                          ),
                            onPressed: () {
                              NavigateUtil().navigateToScreen(context, const LoginScreen());
                            },
                            child: Text(
                              AppStrings.startScreenLoginButton,
                              style: getSmallStyle(
                                color: AppColors.primary,
                                fontSize: 18.0,
                              ),
                            )
                        ),
                        16.ph,
                        OutlinedButton(
                          style: getOutlinedButtonStyle(
                            color: AppColors.white
                          ),
                            onPressed: () {
                              NavigateUtil().navigateToScreen(context, const RegisterScreen());
                            },
                            child: Text(
                              AppStrings.startScreenRegisterButton,
                              style: getSmallStyle(
                                color: AppColors.white,
                                fontSize: 18.0,
                              ),
                            )
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
