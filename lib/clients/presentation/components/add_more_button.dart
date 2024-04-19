import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/screens/add_client_tabs_screen.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/services/services_locator.dart';

class AddMoreButton extends StatelessWidget {

  final Client client;
  const AddMoreButton({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ClientsBloc>(context).add(AddClientEvent(
          client.type == 1,
          client.name ?? '',
          client.phone ?? '',
          client.address,
        ));
        NavigateUtil().navigateToScreen(context, BlocProvider.value(
          value: instance<ClientsBloc>(),
          child: const AddClientTabsScreen(currentTab: 1,),
        ),);
      },
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff1F3A6F),
                Color(0xff3D6AC1),
              ],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.clientsScreenAddMore,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontSize: 14.0,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
