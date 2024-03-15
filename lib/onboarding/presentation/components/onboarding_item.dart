import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/onboarding/data/onboarding_model.dart';

import '../../../auth/presentation/screens/login_screen.dart';

class OnboardingItem extends StatelessWidget {

  final OnBoardingModel onBoardingModel;
  final int pageIndex;
  final PageController controller;

  const OnboardingItem({
    super.key,
    required this.onBoardingModel,
    required this.pageIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onBoardingModel.image!,
        ),
        const SizedBox(height: 40),
        Text(
          onBoardingModel.title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            onBoardingModel.body!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: 120),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: pageIndex == 2
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: pageIndex != 2,
                child: GestureDetector(
                  onTap: () {
                    NavigateUtil().navigateAndClear(context, const LoginScreen());
                  },
                  child: const Text(
                    AppStrings.skip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageIndex == 2
                      ? NavigateUtil().navigateAndClear(context, const LoginScreen())
                      : controller.animateToPage(pageIndex + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: pageIndex == 2
                    ? Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 137, 95, 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    AppStrings.getStarted,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
                    : Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 137, 95, 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
