import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';
import '../components/next_button.dart';

class ChooseWardSecondScreen extends StatelessWidget {
  const ChooseWardSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsBloc, ClientsState>(
  builder: (context, state) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenChooseWardProduct,
            image: AppAssets.person),
        // todo fridge name
        // 16.ph,
        // ThirdAppBar(
        //     text: '${state.ward.name}',
        //     image: AppAssets.goods),
        16.ph,
        GridView.count(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 1.1,
          children: List.generate(state.wards.length, (index) {
            return InkWell(
              onTap: () {

              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2E5AAF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    state.wards[index].name ?? '',
                    style: getSmallStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeightManager.medium),
                  ),
                ),
              ),
            );
          }),
        ),
        16.ph,
        NextButton(onClick: () {
          showLoading(context);
          BlocProvider.of<ClientsBloc>(context).add(FinishEvent());
        }),
        const CancelButton(),
      ],
    );
  },
);
  }
}
