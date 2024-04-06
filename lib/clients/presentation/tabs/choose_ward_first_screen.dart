import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';

class ChooseWardFirstScreen extends StatelessWidget {

  final Function goNext;
  const ChooseWardFirstScreen({super.key, required this.goNext});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenChooseWard,
            image: AppAssets.person),
        // todo fridge name
        // 16.ph,
        // const ThirdAppBar(
        //     text: '${AppStrings.addClientScreeFridge} على محمود',
        //     image: AppAssets.goods),
        16.ph,
        BlocBuilder<ClientsBloc, ClientsState>(
          builder: (context, state) {
            return GridView.count(
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
                    BlocProvider.of<ClientsBloc>(context)
                        .add(ChooseWardEvent(state.wards[index]));
                    goNext();
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
            );
          },
        ),
        16.ph,
        // NextButton(onClick: () {
        //   goNext();
        // }),
        const CancelButton(),
      ],
    );
  }
}
