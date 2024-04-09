import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/components/enter_button.dart';

import '../../../core/components/decorations.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../components/size_form_field.dart';

class WardSettingsScreen extends StatefulWidget {

  final Ward ward;
  const WardSettingsScreen({super.key, required this.ward});

  @override
  State<WardSettingsScreen> createState() => _WardSettingsScreenState();
}

class _WardSettingsScreenState extends State<WardSettingsScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WardsBloc, WardsState>(
  listener: (context, state) {
    if (state is UpdateWardSettingsSuccessState) {
      NavigateUtil().navigateUp(context);
      NavigateUtil().navigateUp(context);
      NavigateUtil().navigateUp(context);
      // BlocProvider.of<WardsBloc>(context).add(GetAllStoresEvent(widget.ward));
    } else if (state is UpdateWardSettingsErrorState) {
      NavigateUtil().navigateUp(context);
      showError(context, state.errorMessage, () {});
    }
  },
  child: SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(canNavigateUp: true),
                const SecondaryAppBarWithImage(
                    text: AppStrings.wardSettingsScreenTitle,
                    image: AppAssets.goods,
                ),
                16.ph,
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppStrings.wardSettingsScreenLength,
                            style: getSmallStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: 17,
                            ),
                          ),
                          16.ph,
                          SizedBox(
                              width: (context.width / 3),
                              height: 45,
                              child: SizeFormField(sizeController: widthController)
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Icon(Icons.close, size: 16,),
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings.wardSettingsScreenWidth,
                            style: getSmallStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: 17,
                            ),
                          ),
                          16.ph,
                          SizedBox(
                              width: (context.width / 3),
                              height: 45,
                              child: SizeFormField(sizeController: heightController)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                32.ph,
                EnterButton(onTap: () {
                  if (validate != null && validate == true) {
                    showLoading(context);
                    BlocProvider.of<WardsBloc>(context).add(UpdateWardSettingsEvent(
                        widget.ward.id ?? -1,
                        int.parse(widthController.text),
                        int.parse(heightController.text))
                    );
                  }
                }),
                const BackButton2()
              ],
            ),
          ),
        )
    ),
);
  }
}
