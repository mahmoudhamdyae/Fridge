import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/states/empty_screen.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/home/domain/entities/product.dart';
import 'package:fridge/home/presentation/bloc/home_bloc.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(AppStrings.appName),
        body: BlocProvider(
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
        ),
      ),
    );
  }
}
