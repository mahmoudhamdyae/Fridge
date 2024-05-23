import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/screens/all_transactions_screen.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/services/services_locator.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';

class ShowAllTransactionsButton extends StatelessWidget {

  final int amountPaid;
  final int amountRemain;
  final String clientName;
  final int clientId;

  const ShowAllTransactionsButton({
    super.key,
    required this.amountPaid,
    required this.amountRemain,
    required this.clientName,
    required this.clientId
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigateUtil().navigateToScreen(
            context,
            BlocProvider.value(
              value: instance<ClientsBloc>(),
              child: AllTransactionsScreen(
                amountPaid: amountPaid,
                amountRemain: amountRemain,
                clientName: clientName,
                clientId: clientId,
              ),
            )
        );
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
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
          child: Text(
            AppStrings.clientsScreenShowAllTransactions,
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
