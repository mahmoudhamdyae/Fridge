
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/home/presentation/screens/home_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/enums/auth_enums.dart';
import '../../../core/services/services_locator.dart';
import '../bloc/auth_bloc.dart';
import '../components/email_form_field.dart';
import '../components/login_button.dart';
import '../components/logo_and_title_widget.dart';
import '../components/password_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            NavigateUtil().navigateUp(context);
            showError(context, 'message', () {});
          } else if (state.status == AuthStatus.authenticated) {
            NavigateUtil().navigateAndClear(context, const HomeScreen());
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(AppStrings.appName),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.05),
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoAndTitleWidget(),
                      EmailFormField(emailController: emailController),
                      PasswordFormField(
                          passwordController: passwordController),
                      LoginButton(
                        onTap: () {
                          if (validate != null && validate == true) {
                            showLoading(context);
                            BlocProvider.of<AuthBloc>(context).add(LoginRequested(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ));
                            // context.read<AuthBloc>().add(LoginRequested(
                            //   emailController.text.trim(),
                            //   passwordController.text.trim(),
                            // ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}