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

class AddProductScreen extends StatefulWidget {
  final Function(String productType) moveForward;

  const AddProductScreen({super.key, required this.moveForward});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController unitWeightController = TextEditingController();
  TextEditingController totalWeightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String chosenProductType = AppStrings.addClientScreenProductTypeHint;
  String chosenPackagingType = AppStrings.addClientScreenPackagingTypeHint;

  bool? get validate => _formKey.currentState?.validate();

  @override
  void initState() {
    super.initState();
    ClientsState state = BlocProvider.of<ClientsBloc>(context).state;
    numberController.text = (state.productToAdd.number ?? '').toString();
    unitWeightController.text = (state.productToAdd.unitWeight ?? '').toString();
    totalWeightController.text =
        (state.productToAdd.totalWeight ?? '').toString();
    priceController.text = (state.productToAdd.price ?? '').toString();
    chosenProductType = state.productToAdd.productType ??
        AppStrings.addClientScreenProductTypeHint;
    chosenPackagingType = state.productToAdd.packagingType ??
        AppStrings.addClientScreenPackagingTypeHint;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenAddProducts,
            image: AppAssets.person,
          ),
          32.ph,
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
                    value: chosenPackagingType,
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
                value: chosenProductType,
                chosenType: (chosenType) {
                  setState(() {
                    chosenProductType = chosenType;
                  });
                },
              )),
            ],
          ),
          16.ph,
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenNumberLabel,
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
          16.ph,
          Row(
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
                      unitWeightController: unitWeightController)),
            ],
          ),
          16.ph,
          Row(
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
                      totalWeightController: totalWeightController)),
            ],
          ),
          16.ph,
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  AppStrings.addClientScreenStorePriceLabel,
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
          // 32.ph,
          // InkWell(
          //   onTap: () {},
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const Icon(
          //         Icons.add,
          //         color: Color(0xff193263),
          //         size: 16.0,
          //       ),
          //       4.pw,
          //       Text(
          //         AppStrings.addClientScreenAddProduct,
          //         style: getSmallStyle(
          //           fontWeight: FontWeightManager.medium,
          //           fontSize: 14.0,
          //           color: const Color(0xff193263),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          32.ph,
          NextButton(onClick: () {
            // if (validate != null && validate == true) {
            BlocProvider.of<ClientsBloc>(context).add(AddProductEvent(
              chosenProductType,
              chosenPackagingType,
              int.parse(numberController.text),
              int.parse(unitWeightController.text),
              int.parse(totalWeightController.text),
              double.parse(priceController.text),
            ));
            widget.moveForward(chosenProductType);
            // }
          }),
          const CancelButton(),
        ],
      ),
    );
  }
}
