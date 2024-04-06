import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';
import '../components/next_button.dart';

class ChooseWardSecondScreen extends StatefulWidget {
  const ChooseWardSecondScreen({super.key});

  @override
  State<ChooseWardSecondScreen> createState() => _ChooseWardSecondScreenState();
}

class _ChooseWardSecondScreenState extends State<ChooseWardSecondScreen> {

  int? selectedIndex;

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
          crossAxisCount: state.ward.width ?? 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 1.1,
          children: List.generate(((state.ward.width ?? 1) * (state.ward.height ?? 1)), (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  debugPrint('======= index x ${((index) / (state.ward.width ?? 1)).floor()}');
                  debugPrint('======= index y ${((index) % (state.ward.width ?? 1))}');
                });
              },
              child: DottedBorder(
                child: Center(
                  child: Text(
                    selectedIndex == index ? state.productToAdd.productType ?? '' : '',
                    style: getSmallStyle(
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
          BlocProvider.of<ClientsBloc>(context).add(FinishEvent(
              ((selectedIndex ?? 0) / (state.ward.width ?? 1)).floor(),
              ((selectedIndex ?? 0) % (state.ward.width ?? 1)),
          ));
        }),
        const CancelButton(),
      ],
    );
  },
);
  }
}
