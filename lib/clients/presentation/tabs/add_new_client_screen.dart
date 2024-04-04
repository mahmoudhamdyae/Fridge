import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/components/client_address_form_field.dart';
import 'package:fridge/clients/presentation/components/client_name_form_field.dart';
import 'package:fridge/clients/presentation/components/client_phone_form_field.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';
import '../components/next_button.dart';
import '../components/trader_dealer_button.dart';

class AddNewClientScreen extends StatefulWidget {

  final Function moveForward;
  const AddNewClientScreen({super.key, required this.moveForward});

  @override
  State<AddNewClientScreen> createState() => _AddNewClientScreenState();
}

class _AddNewClientScreenState extends State<AddNewClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  bool? isTrader;

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const SecondaryAppBar(
              text: AppStrings.addClientScreenAddClient,
              icon: Icons.person_add_sharp),
          Text(
            AppStrings.addClientScreenChooseType,
            style: getSmallStyle(fontWeight: FontWeightManager.medium),
          ),
          16.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              8.pw,
              TraderDealerButton(
                text: AppStrings.addClientScreenTrader,
                isSelected: isTrader,
                onClicked: () {
                  setState(() {
                    isTrader = true;
                  });
                },
              ),
              16.pw,
              TraderDealerButton(
                text: AppStrings.addClientScreenDealer,
                isSelected: !(isTrader ?? true),
                onClicked: () {
                  setState(() {
                    isTrader = false;
                  });
                },
              ),
              8.pw,
            ],
          ),
          32.ph,
          ClientNameFormField(clientNameController: clientNameController),
          16.ph,
          ClientPhoneFormField(
              clientPhoneController: clientPhoneController),
          16.ph,
          ClientAddressFormField(
              clientAddressController: clientAddressController),
          32.ph,
          Builder(
              builder: (context) {
                return NextButton(
                  onClick: () {
                    if (validate != null && validate == true) {
                      BlocProvider.of<ClientsBloc>(context).add(AddClientEvent(
                          isTrader ?? true,
                          clientNameController.text,
                          clientPhoneController.text,
                          clientAddressController.text));
                      widget.moveForward();
                    }
                  },
                );
              }
          ),
          8.ph,
          const CancelButton(),
        ],
      ),
    );
  }
}
