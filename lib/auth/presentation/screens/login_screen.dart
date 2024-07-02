import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/components/auth_app_bar.dart';
import 'package:fridge/auth/presentation/screens/register_screen.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../bloc/auth_bloc.dart';
import '../components/phone_form_field.dart';
import '../components/auth_button.dart';
import '../components/password_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            const AuthAppBar(title: AppStrings.loginScreenTitle,),
            Container(
              height: MediaQuery.of(context).size.height - 215,
              padding: const EdgeInsets.only(
                top: 32,
                right: 32,
                left: 32,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                  ),
                  color: AppColors.white
              ),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    // shrinkWrap: true,
                    // physics: const ClampingScrollPhysics(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.loginScreenWelcome,
                        style: getLargeStyle(
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      8.ph,
                      Text(
                        AppStrings.loginScreenWelcomeDesc,
                        style: getSmallStyle(),
                      ),
                      16.ph,
                      Text(
                        AppStrings.loginScreenPhoneLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      8.ph,
                      PhoneFormField(phoneController: phoneController),
                      8.ph,
                      Text(
                        AppStrings.loginScreenPasswordLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      8.ph,
                      PasswordFormField(
                          passwordController: passwordController),
                      const Spacer(),
                      AuthButton(
                        onTap: () {
                          if (validate != null && validate == true) {
                            TextInput.finishAutofillContext();
                            showLoading(context);
                            BlocProvider.of<AuthBloc>(context).add(LoginRequested(
                              phoneController.text.trim(),
                              passwordController.text.trim(),
                            ));
                          }
                        }, text: AppStrings.loginScreenLoginButton,
                      ),
                      16.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.loginScreenNoAccount,
                            style: getSmallStyle(
                              color: AppColors.h3
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                NavigateUtil().navigateAndClear(context, const RegisterScreen());
                              },
                              child: Text(
                                AppStrings.loginScreenNewAccount,
                                style: getSmallStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.primary
                                ),
                              )
                          ),
                        ],
                      ),
                      18.ph,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}