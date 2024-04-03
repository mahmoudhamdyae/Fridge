import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/components/cancel_button.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/components/dialogs/loading_dialog.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/settings/presentation/bloc/settings_bloc.dart';
import 'package:fridge/settings/presentation/components/add_button.dart';
import 'package:fridge/settings/presentation/components/complete_button.dart';
import 'package:fridge/settings/presentation/components/packaging_type_form_field.dart';
import 'package:fridge/settings/presentation/components/product_type_form_field.dart';
import 'package:fridge/settings/presentation/components/unit_price_form_field.dart';
import 'package:fridge/settings/presentation/components/wards_number_form_field.dart';

import '../../../core/components/decorations.dart';
import '../../../core/enums/request_state.dart';
import '../../../core/resources/app_assets.dart';

class SettingsScreen extends StatefulWidget {

  final BuildContext blocContext;
  const SettingsScreen({super.key, required this.blocContext});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController wardsNumberController = TextEditingController();
  List<TextEditingController> productTypeController = [];
  List<TextEditingController> packagingTypeController = [];
  TextEditingController unitPriceController = TextEditingController();
  String _unit = AppStrings.settingsScreenUnitKiloGram;

  bool? get validate => _formKey.currentState?.validate();
  late SettingsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<SettingsBloc>();
    bloc.add(GetSettingsEvent());

    wardsNumberController.text = (bloc.state.settingsResponse.data?.partsCount ?? '').toString();
    unitPriceController.text = (bloc.state.settingsResponse.data?.price ?? '').toString();
    _unit = (bloc.state.settingsResponse.data?.units ?? AppStrings.settingsScreenUnitKiloGram).toString();

    // Product Type
    productTypeController = [];
    bloc.state.settingsResponse.data?.products?.forEach((element) {
      productTypeController.add(TextEditingController(text: element));
    });

    // Packaging Type
    packagingTypeController = [];
    bloc.state.settingsResponse.data?.boxing?.forEach((element) {
      packagingTypeController.add(TextEditingController(text: element));
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in productTypeController) {
      element.dispose();
    }
    for (var element in packagingTypeController) {
      element.dispose();
    }
    wardsNumberController.dispose();
    unitPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    instance<SettingsBloc>().add(GetSettingsEvent());
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: context.height,
        padding: getMainPadding(context),
        decoration: getMainDecoration(),
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (BuildContext context, SettingsState state) {
            if (state.updateSettingsState == RequestState.loading) {
              showLoading(context);
            } else if (state.updateSettingsState == RequestState.error) {
              NavigateUtil().navigateUp(context);
              showError(context, state.updateSettingsErrorMessage, () {});
            } else if (state.updateSettingsState == RequestState.loaded) {
              NavigateUtil().navigateUp(context);
              NavigateUtil().navigateUp(context);
            }
          },
          builder: (context, state) {
            if (state.getSettingsState == RequestState.loading) {
              // return const LoadingScreen();
            } else if (state.getSettingsState == RequestState.error) {
              // return ErrorScreen(error: state.getSettingsErrorMessage);
            }


            return Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const MainAppBar(
                    canNavigateUp: true,
                  ),
                  const SecondaryAppBarWithImage(
                      text: AppStrings.settingsScreenTitle,
                      image: AppAssets.goods),
                  16.ph,
                  Row(
                    children: [
                      Text(
                        AppStrings.settingsScreenWardsNumberLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18.0,
                        ),
                      ),
                      16.pw,
                      Expanded(
                          child: WardsNumberFormField(
                        wardsNumberController: wardsNumberController,
                      )),
                    ],
                  ),
                  32.ph,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.settingsScreenProductTypeLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18.0,
                        ),
                      ),
                      16.pw,
                      Expanded(
                          child: ProductTypeFormField(
                              productTypeController: productTypeController)),
                      12.pw,
                      AddButton(onClick: () {
                        setState(() {
                          productTypeController.add(TextEditingController(text: ''));
                        });
                      },),
                    ],
                  ),
                  32.ph,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.settingsScreenPackagingTypeLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18.0,
                        ),
                      ),
                      16.pw,
                      Expanded(child: PackagingTypeFormField(packagingTypeController: packagingTypeController,)),
                      12.pw,
                      AddButton(onClick: () {
                        setState(() {
                          packagingTypeController.add(TextEditingController(text: ''));
                        });
                      },),
                    ],
                  ),
                  32.ph,
                  Text(
                    AppStrings.settingsScreenUsedUnit,
                    style: getSmallStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 18.0,
                    ),
                  ),
                  8.ph,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: AppStrings.settingsScreenUnitGram,
                                groupValue: _unit,
                                onChanged: (value) {
                                  setState(() {
                                    _unit = value ?? '';
                                  });
                                }),
                            Text(
                              AppStrings.settingsScreenUnitGram,
                              style: getSmallStyle(
                                  fontWeight: FontWeightManager.medium),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: AppStrings.settingsScreenUnitKiloGram,
                                groupValue: _unit,
                                onChanged: (value) {
                                  setState(() {
                                    _unit = value ?? '';
                                  });
                                }),
                            Text(
                              AppStrings.settingsScreenUnitKiloGram,
                              style: getSmallStyle(
                                  fontWeight: FontWeightManager.medium),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: AppStrings.settingsScreenUnitTon,
                                groupValue: _unit,
                                onChanged: (value) {
                                  setState(() {
                                    _unit = value ?? '';
                                  });
                                }),
                            Text(
                              AppStrings.settingsScreenUnitTon,
                              style: getSmallStyle(
                                  fontWeight: FontWeightManager.medium),
                            )
                          ],
                        ),
                      ]),
                  8.ph,
                  32.ph,
                  Row(
                    children: [
                      Text(
                        AppStrings.settingsScreenUnitPriceLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18.0,
                        ),
                      ),
                      16.pw,
                      Expanded(
                          child: UnitPriceFormField(
                        unitPriceController: unitPriceController,
                      )),
                    ],
                  ),
                  64.ph,
                  CompleteButton(
                    onTap: () {
                      if (validate != null && validate == true) {
                        List<String> product = [];
                        for (var element in productTypeController) {
                          product.add(element.text);
                        }
                        List<String> boxing = [];
                        for (var element in packagingTypeController) {
                          boxing.add(element.text);
                        }
                        BlocProvider.of<SettingsBloc>(context)
                            .add(UpdateSettingsEvent(
                            product,
                            boxing,
                            _unit,
                            int.parse(unitPriceController.text),
                            int.parse(wardsNumberController.text),
                        ));
                      }
                    },
                  ),
                  8.ph,
                  const CancelButton(),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
