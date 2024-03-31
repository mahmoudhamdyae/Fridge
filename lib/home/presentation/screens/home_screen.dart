import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/home/presentation/composables/home_screen_item.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: /*BlocProvider(
          create: (BuildContext context) => instance<HomeBloc>()..add(GetProducts()),
          child: BlocBuilder(
            bloc: instance<HomeBloc>(),
            builder: (BuildContext context, HomeState state) {
              switch(state.productsState) {
                case RequestState.loading:
                  return const LoadingScreen();
                case RequestState.error:
                  return ErrorScreen(error: state.productsErrorMessage);
                case RequestState.loaded:
                  List<Product> products = state.products;
                  if (products.isEmpty) {
                    return const EmptyScreen(emptyString: 'emptyString');
                  }
                  return Text(products.length.toString());
              }
            },),
        )*/Padding(
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.04)),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              const MainAppBar(),
              TextFormField(
                decoration: getFilledTextFieldDecoration(
                  hint: AppStrings.homeScreenSearchHint,
                  radius: 20.0,
                  prefixIcon: Icons.search,
                  textStyle: getSmallStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeightManager.medium,
                      color: AppColors.dark2
                  )
                ),
                // controller: addressController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenClients,
                onTab: () {},
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenSettings,
                onTab: () {},
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenWards,
                onTab: () {},
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenExpenses,
                onTab: () {},
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenReports,
                onTab: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
