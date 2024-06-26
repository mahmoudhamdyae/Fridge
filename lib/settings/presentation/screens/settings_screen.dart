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
import 'package:fridge/settings/presentation/components/del_button.dart';
import 'package:fridge/settings/presentation/components/large_bags_form_field.dart';
import 'package:fridge/settings/presentation/components/packaging_type_form_field.dart';
import 'package:fridge/settings/presentation/components/product_type_form_field.dart';
import 'package:fridge/settings/presentation/components/small_bags_form_field.dart';
import 'package:fridge/settings/presentation/components/unit_price_form_field.dart';
import 'package:fridge/settings/presentation/components/wards_number_form_field.dart';

import '../../../core/components/decorations.dart';
import '../../../core/resources/app_assets.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController wardsNumberController = TextEditingController();
  List<TextEditingController> productTypeController = [];
  List<TextEditingController> packagingTypeController = [];
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController smallBagsController = TextEditingController();
  TextEditingController largeBagsController = TextEditingController();
  String _unit = AppStrings.settingsScreenUnitKiloGram;

  bool? get validate => _formKey.currentState?.validate();
  late SettingsBloc bloc;

  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    bloc = instance<SettingsBloc>();
    bloc.add(GetSettingsEvent());
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
    smallBagsController.dispose();
    largeBagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: context.height,
        padding: getMainPadding(context),
        decoration: getMainDecoration(),
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
            BlocConsumer<SettingsBloc, SettingsState>(
              listenWhen: (previous, current) =>
              current is UpdateSettingsLoadingState ||
              current is UpdateSettingsErrorState ||
              current is UpdateSettingsSuccessState
              ,
              listener: (BuildContext context, SettingsState state) {
                if (state is UpdateSettingsLoadingState) {
                  showLoading(context);
                } else if (state is UpdateSettingsErrorState) {
                  NavigateUtil().navigateUp(context);
                  showError(context, state.errorMessage, () {});
                } else if (state is UpdateSettingsSuccessState) {
                  NavigateUtil().navigateUp(context);
                  NavigateUtil().navigateUp(context);
                }
              },
              buildWhen: (previous, current) =>
              current is GetSettingsLoadingState ||
              current is GetSettingsErrorState ||
              current is GetSettingsLoadedState,
              builder: (context, state) {
                if (state is GetSettingsLoadingState) {
                  return const LoadingScreen();
                } else if (state is GetSettingsErrorState) {
                  return ErrorScreen(error: state.errorMessage);
                } else if (state is GetSettingsLoadedState) {
                  if (isFirstTime) {
                    _unit = (state.units).toString();

                    wardsNumberController.text = (state.partsCount).toString();
                    unitPriceController.text = (state.price).toString();
                    smallBagsController.text = (state.smallBags).toString();
                    largeBagsController.text = (state.largeBags).toString();

                    // Product Type
                    productTypeController = [];
                    for (var element in (state.products ?? [])) {
                      productTypeController.add(TextEditingController(text: element));
                    }

                    // Packaging Type
                    packagingTypeController = [];
                    for (var element in (state.boxing ?? [])) {
                      packagingTypeController.add(TextEditingController(text: element));
                    }
                    isFirstTime = false;
                  }

                  return Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
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
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                AppStrings.settingsScreenProductTypeLabel,
                                style: getSmallStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            16.pw,
                            Expanded(
                                child: ProductTypeFormField(
                                    productTypeController: productTypeController)
                            ),
                            16.pw,
                            SizedBox(
                                height: 70.0 * productTypeController.length,
                                width: 32,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: productTypeController.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                        height: 70,
                                        child: DelButton(onClick: () {
                                          setState(() {
                                            if (productTypeController.length != 1) {
                                              productTypeController.removeAt(index);
                                            }
                                          });
                                        })
                                    );
                                  },
                                ),
                            ),
                            12.pw,
                            SizedBox(
                              height: 70,
                              width: 32,
                              child: AddButton(onClick: () {
                                setState(() {
                                  productTypeController.add(TextEditingController(text: ''));
                                });
                              },),
                            ),
                          ],
                        ),
                        32.ph,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                AppStrings.settingsScreenPackagingTypeLabel,
                                style: getSmallStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            16.pw,
                            Expanded(child: PackagingTypeFormField(packagingTypeController: packagingTypeController,)),
                            16.pw,
                            SizedBox(
                              height: 70.0 * packagingTypeController.length,
                              width: 32,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: packagingTypeController.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                      height: 70,
                                      child: DelButton(onClick: () {
                                        setState(() {
                                          if (packagingTypeController.length != 1) {
                                            packagingTypeController.removeAt(index);
                                          }
                                        });
                                      })
                                  );
                                },
                              ),
                            ),
                            12.pw,
                            SizedBox(
                              height: 70,
                              width: 32,
                              child: AddButton(onClick: () {
                                setState(() {
                                  packagingTypeController.add(TextEditingController(text: ''));
                                });
                              },),
                            ),
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
                                          BlocProvider.of<SettingsBloc>(context).add(UpdateUnitEvent(_unit));
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
                                          BlocProvider.of<SettingsBloc>(context).add(UpdateUnitEvent(_unit));
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
                                          BlocProvider.of<SettingsBloc>(context).add(UpdateUnitEvent(_unit));
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
                        32.ph,
                        Row(
                          children: [
                            Text(
                              AppStrings.settingsScreenSmallBagsLabel,
                              style: getSmallStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: 18.0,
                              ),
                            ),
                            16.pw,
                            Expanded(
                                child: SmallBagsFormField(
                                  smallBagsController: smallBagsController,
                                )),
                          ],
                        ),
                        32.ph,
                        Row(
                          children: [
                            Text(
                              AppStrings.settingsScreenLargeBagsLabel,
                              style: getSmallStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: 18.0,
                              ),
                            ),
                            16.pw,
                            Expanded(
                                child: LargeBagsFormField(
                                  largeBagsController: largeBagsController,
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
                                double.parse(unitPriceController.text),
                                int.parse(wardsNumberController.text),
                                double.parse(smallBagsController.text),
                                double.parse(largeBagsController.text),
                              ));
                            }
                          },
                        ),
                        8.ph,
                        const CancelButton(),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
