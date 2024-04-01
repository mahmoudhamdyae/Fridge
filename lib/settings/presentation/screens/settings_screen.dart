import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/components/cancel_button.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/settings/presentation/components/complete_button.dart';
import 'package:fridge/settings/presentation/components/packaging_type_form_field.dart';
import 'package:fridge/settings/presentation/components/product_type_form_field.dart';
import 'package:fridge/settings/presentation/components/unit_price_form_field.dart';

import '../../../core/components/decorations.dart';
import '../../../core/resources/app_assets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productTypeController = TextEditingController();
  String packagingTypeController = '';
  TextEditingController unitPriceController = TextEditingController();
  String _unit = AppStrings.settingsScreenUnitKiloGram;

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const MainAppBar(canNavigateUp: true,),
                  const SecondaryAppBarWithImage(
                      text: AppStrings.settingsScreenTitle,
                      image: AppAssets.goods
                  ),
                  16.ph,
                  Row(
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
                          child: ProductTypeFormField(productTypeController: productTypeController)
                      ),
                    ],
                  ),
                  32.ph,
                  Row(
                    children: [
                      Text(
                        AppStrings.settingsScreenPackagingTypeLabel,
                        style: getSmallStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: 18.0,
                        ),
                      ),
                      16.pw,
                      Expanded(
                          child: PackagingTypeFormField(chosenPackage: (String package) {
                            setState(() {
                              packagingTypeController = package;
                            });
                          })
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
                              onChanged: (value){
                                setState(() {
                                  _unit = value ?? '';
                                });
                              }
                          ),
                          Text(
                            AppStrings.settingsScreenUnitGram,
                            style: getSmallStyle(
                              fontWeight: FontWeightManager.medium
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: AppStrings.settingsScreenUnitKiloGram,
                              groupValue: _unit,
                              onChanged: (value){
                                setState(() {
                                  _unit = value ?? '';
                                });
                              }
                          ),
                          Text(
                            AppStrings.settingsScreenUnitKiloGram,
                            style: getSmallStyle(
                                fontWeight: FontWeightManager.medium
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: AppStrings.settingsScreenUnitTon,
                              groupValue: _unit,
                              onChanged: (value){
                                setState(() {
                                  _unit = value ?? '';
                                });
                              }
                          ),
                          Text(
                            AppStrings.settingsScreenUnitTon,
                            style: getSmallStyle(
                                fontWeight: FontWeightManager.medium
                            ),
                          )
                        ],
                      ),
                    ]
                  ),
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
                          child: UnitPriceFormField(unitPriceController: unitPriceController,)
                      ),
                    ],
                  ),
                  64.ph,
                  CompleteButton(onTap: () {
                    if (validate != null && validate == true) {
                      // todo Add Event
                    }
                  },),
                  8.ph,
                  const CancelButton(),
                ],
              ),
            ),
          ),
        )
    );
  }
}
