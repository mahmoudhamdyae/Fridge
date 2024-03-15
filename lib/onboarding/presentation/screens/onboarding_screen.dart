import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/onboarding/data/onboarding_model.dart';
import 'package:fridge/onboarding/presentation/components/onboarding_item.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {

  final PageController controller = PageController(initialPage: 0);
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<OnboardingBloc>(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: controller,
                  onPageChanged: (int index) {
                    state.pageIndex = index;
                    BlocProvider.of<OnboardingBloc>(context).add(OnboardingEvent());
                  },
                  itemCount: OnBoardingModel.getItems().length,
                  itemBuilder: (BuildContext context, int index) {
                    return OnboardingItem(
                        onBoardingModel: OnBoardingModel.getItems()[index],
                        pageIndex: index,
                        controller: controller
                    );
                  },
                ),
                Positioned(
                  bottom: 150,
                  child: DotsIndicator(
                    dotsCount: OnBoardingModel.getItems().length,
                    position: state.pageIndex,
                    decorator: DotsDecorator(
                      color: Colors.blue.withOpacity(0.2),
                      activeColor: Colors.blue,
                      size: const Size.square(9.0),
                      activeSize: const Size(36.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
