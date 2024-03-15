import 'package:fridge/core/resources/app_strings.dart';

import '../constants/onboarding_image_asset.dart';

class OnBoardingModel {
  final String? title;
  final String? image;
  final String? body;

  OnBoardingModel._({
    this.title,
    this.image,
    this.body
  });

  static List<OnBoardingModel> getItems() {
    return [
      OnBoardingModel._(
          title: AppStrings.onboardingTitle1,
          image: OnboardingImageAsset.onBoardingImageOne,
          body: AppStrings.onboardingDesc1
      ),
      OnBoardingModel._(
          title: AppStrings.onboardingTitle2,
          image: OnboardingImageAsset.onBoardingImageTwo,
          body: AppStrings.onboardingDesc2
      ),
      OnBoardingModel._(
          title: AppStrings.onboardingTitle3,
          image: OnboardingImageAsset.onBoardingImageThree,
          body: AppStrings.onboardingDesc3
      ),
    ];
  }
}