import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/components/cancel_button.dart';
import 'package:fridge/clients/presentation/components/next_button.dart';
import 'package:fridge/clients/presentation/components/product/add_packaging_type_form_field.dart';
import 'package:fridge/clients/presentation/components/product/add_product_type_form_field.dart';
import 'package:fridge/clients/presentation/components/product/number_form_field.dart';
import 'package:fridge/clients/presentation/components/product/product_price_form_field.dart';
import 'package:fridge/clients/presentation/components/product/total_weight_form_field.dart';
import 'package:fridge/clients/presentation/components/product/unit_weight_form_field.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../components/product/product_paid_form_field.dart';

class AddProductScreen extends StatefulWidget {

  final bool isTrader;
  final Function(String productType) moveForward;

  const AddProductScreen({super.key, required this.moveForward, required this.isTrader});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController unitWeightController = TextEditingController();
  TextEditingController totalWeightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  String chosenProductType = AppStrings.addClientScreenProductTypeHint;
  String chosenPackagingType = AppStrings.addClientScreenPackagingTypeHint;
  String _bagType = AppStrings.addClientScreenBagTypeSmall;

  bool? get validate => _formKey.currentState?.validate();

  @override
  void initState() {
    super.initState();
    ClientsState state = BlocProvider.of<ClientsBloc>(context).state;
    numberController.text = (state.productToAdd.number ?? '').toString();
    unitWeightController.text = (state.productToAdd.unitWeight ?? '').toString();
    totalWeightController.text =
        (state.productToAdd.totalWeight ?? '').toString();
    if (widget.isTrader) {
      priceController.text = (state.productToAdd.price?.toInt() ?? state.remotePrice).toString();
    } else {
      priceController.text = (state.productToAdd.price?.toInt() ??
          (_bagType == AppStrings.addClientScreenBagTypeSmall ? state.remoteSmallBagPrice : state.remoteLargeBagPrice)
      ).toString();
    }
    paidController.text = (state.productToAdd.paid?.toInt() ?? 0.0).toString();
    chosenProductType = state.productToAdd.productType ??
        AppStrings.addClientScreenProductTypeHint;
    chosenPackagingType = state.productToAdd.packagingType ??
        AppStrings.addClientScreenPackagingTypeHint;

    if (state.remotePackagingTypes.length == 1) {
      chosenPackagingType = state.remotePackagingTypes.first;
    }
    if (state.remoteProductsTypes.length == 1) {
      chosenProductType = state.remoteProductsTypes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenAddProducts,
            image: AppAssets.person,
          ),
          32.ph,
          // نوع التغليف
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenPackagingTypeLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: AddPackagingTypeFormField(
                    chosenType: (chosenType) {
                      setState(() {
                        chosenPackagingType = chosenType;
                      });
                      },
                  )
              ),
            ],
          ),
          16.ph,
          // نوع المنتج
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenProductTypeLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: AddProductTypeFormField(
                chosenType: (chosenType) {
                  setState(() {
                    chosenProductType = chosenType;
                  });
                },
              )),
            ],
          ),
          !widget.isTrader ? 16.ph : 0.ph,
          // نوع الشكاير
          !widget.isTrader ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    AppStrings.addClientScreenBagTypeLabel,
                    style: getSmallStyle(
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                        value: AppStrings.addClientScreenBagTypeSmall,
                        groupValue: _bagType,
                        onChanged: (value) {
                          setState(() {
                            _bagType = value ?? '';
                          });
                        }),
                    Text(
                      AppStrings.addClientScreenBagTypeSmall,
                      style: getSmallStyle(
                          fontWeight: FontWeightManager.medium),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: AppStrings.addClientScreenBagTypeBig,
                        groupValue: _bagType,
                        onChanged: (value) {
                          setState(() {
                            _bagType = value ?? '';
                          });
                        }),
                    Text(
                      AppStrings.addClientScreenBagTypeBig,
                      style: getSmallStyle(
                          fontWeight: FontWeightManager.medium),
                    )
                  ],
                ),
              ]) : Container(),
          16.ph,
          // العدد // عدد الشكاير
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  widget.isTrader ? AppStrings.addClientScreenNumberLabel : AppStrings.addClientScreenBagsNumberLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: NumberFormField(numberController: numberController)),
            ],
          ),
          widget.isTrader ? 16.ph : 0.ph,
          // الوزن للوحدة
          widget.isTrader ? Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenUnitWeightLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: UnitWeightFormField(
                    numberController: numberController,
                    unitWeightController: unitWeightController,
                    totalWeightController: totalWeightController,
                  )),
            ],
          ) : Container(),
          widget.isTrader ? 16.ph : 0.ph,
          // الوزن الكلى
          widget.isTrader ? Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenTotalWeightLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: TotalWeightFormField(
                    numberController: numberController,
                    unitWeightController: unitWeightController,
                    totalWeightController: totalWeightController,
                  )),
            ],
          ) : Container(),
          16.ph,
          // سعر التخزين // سعر الشكارة الواحدة
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  widget.isTrader ? AppStrings.addClientScreenStorePriceLabel : AppStrings.addClientScreenStoreBagPriceLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: ProductPriceFormField(
                      productPriceController: priceController)),
            ],
          ),
          16.ph,
          // المبلغ المدفوع
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenStorePaidLabel,
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
              16.pw,
              Expanded(
                  child: ProductPaidFormField(
                      productPaidController: paidController)),
            ],
          ),
          32.ph,
          // التالى
          NextButton(onClick: () {
            if (validate != null && validate == true) {
              BlocProvider.of<ClientsBloc>(context).add(AddProductEvent(
                chosenProductType,
                chosenPackagingType,
                numberController.text,
                unitWeightController.text,
                totalWeightController.text,
                double.parse(priceController.text),
                double.parse(paidController.text),
              ));
              widget.moveForward(chosenProductType);
            }
          }),
          // الغاء
          const CancelButton(),
        ],
      ),
    );
  }
}
