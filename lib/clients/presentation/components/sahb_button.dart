import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';

class SahbButton extends StatelessWidget {

  final Function onClick;

  const SahbButton({
    super.key,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientsBloc, ClientsState>(
      listenWhen: (previous, current) =>
          current.storeSahbState == RequestState.loaded ||
          current.storeSahbState == RequestState.error
      ,
      listener: (context, state) {
        if (state.storeSahbState == RequestState.error) {
          NavigateUtil().navigateUp(context);
          showError(context, state.storeSahbErrorMessage, () {});
        } else if (state.storeSahbState == RequestState.loaded) {
          Future.delayed(Duration.zero).then((value) {
            NavigateUtil().navigateUp(context);
            NavigateUtil().navigateUp(context);
          });
        }
      },
      child: InkWell(
        onTap: () { onClick(); },
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
            padding: const EdgeInsets.symmetric(
                vertical: 12.0, horizontal: 32.0),
            child: Text(
              AppStrings.clientsScreenSahbButton,
              textAlign: TextAlign.center,
              style: getSmallStyle(
                fontSize: 14.0,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
