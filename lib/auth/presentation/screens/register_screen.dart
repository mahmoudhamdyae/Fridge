
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/components/auth_app_bar.dart';
import 'package:fridge/auth/presentation/components/fridge_name_form_field.dart';
import 'package:fridge/auth/presentation/components/name_form_field.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../bloc/auth_bloc.dart';
import '../components/address_form_field.dart';
import '../components/phone_form_field.dart';
import '../components/auth_button.dart';
import '../components/password_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fridgeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorRamps2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AuthAppBar(title: AppStrings.registerScreenTitle,),
              Container(
                padding: EdgeInsets.only(
                  top: context.dynamicHeight(.04),
                  right: context.dynamicHeight(.03),
                  left: context.dynamicHeight(.03),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                    ),
                    color: AppColors.white
                ),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.registerScreenJoinNow,
                          style: getLargeStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        4.ph,
                        Text(
                          AppStrings.registerScreenJoinNowDesc,
                          style: getSmallStyle(),
                        ),
                        16.ph,
                        Text(
                          AppStrings.registerScreenNameLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        8.ph,
                        NameFormField(nameController: nameController),
                        16.ph,
                        Text(
                          AppStrings.registerScreenPhoneLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        8.ph,
                        PhoneFormField(phoneController: phoneController),
                        16.ph,
                        Text(
                          AppStrings.registerScreenPasswordLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        8.ph,
                        PasswordFormField(
                            passwordController: passwordController),
                        16.ph,
                        Text(
                          AppStrings.registerScreenAddressLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        8.ph,
                        FridgeNameFormField(fridgeNameController: fridgeNameController),
                        16.ph,
                        Text(
                          AppStrings.registerScreenAddressLabel,
                          style: getSmallStyle(
                            fontWeight: FontWeightManager.medium,
                          ),
                        ),
                        8.ph,
                        AddressFormField(addressController: addressController),
                        24.ph,
                        AuthButton(
                          onTap: () {
                            if (validate != null && validate == true) {
                              showLoading(context);
                              BlocProvider.of<AuthBloc>(context).add(RegisterRequested(
                                nameController.text.trim(),
                                phoneController.text.trim(),
                                passwordController.text.trim(),
                                addressController.text.trim(),
                                fridgeNameController.text.trim(),
                              ));
                            }
                          }, text: AppStrings.registerScreenRegisterButton,
                        ),
                        8.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.registerScreenExistingAccount,
                              style: getSmallStyle(),
                            ),
                            4.pw,
                            TextButton(
                                onPressed: () {
                                  NavigateUtil().navigateToScreen(context, const LoginScreen());
                                },
                                child: Text(
                                  AppStrings.registerScreenLogin,
                                  style: getSmallStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.dark1
                                  ),
                                )
                            ),
                          ],
                        ),
                        16.ph
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}