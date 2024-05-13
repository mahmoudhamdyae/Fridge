import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:fridge/clients/presentation/components/client/client_address_form_field.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../domain/entities/contact.dart';
import '../bloc/clients_bloc.dart';
import '../components/cancel_button.dart';
import '../components/client/client_name_form_field.dart';
import '../components/client/client_phone_form_field.dart';
import '../components/next_button.dart';
import '../components/trader_dealer_button.dart';

class AddNewClientScreen extends StatefulWidget {

  final Function(bool) moveForward;
  final List<CustomContact> customContacts;

  const AddNewClientScreen({
    super.key,
    required this.moveForward,
    required this.customContacts
  });

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

  final FlutterContactPicker _contactPicker = FlutterContactPicker();

  @override
  void initState() {
    super.initState();
    ClientsState state = BlocProvider.of<ClientsBloc>(context).state;
    clientNameController.text = state.clientName;
    clientPhoneController.text = state.clientPhone;
    clientAddressController.text = state.clientAddress;
    isTrader = state.clientType == 0;
  }

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
              icon: Icons.person_add_sharp,
          ),
          16.ph,
          InkWell(
            onTap: () async {
              Contact? contact = await _contactPicker.selectContact();
              clientNameController.text = contact?.fullName ?? '';
              clientPhoneController.text = contact?.phoneNumbers?.first.replaceAll(' ', '') ?? '';
            },
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'إضافة من قائمة الاتصال',
                      style: getSmallStyle(),
                    ),
                    const Icon(Icons.person_add_sharp),
                  ],
                ),
              ),
            ),
          ),
          16.ph,
          ClientNameFormField(
            clientNameController: clientNameController,
            clientPhoneController: clientPhoneController,
            customContacts: widget.customContacts,
          ),
          16.ph,
          ClientPhoneFormField(
            clientPhoneController: clientPhoneController,
            clientNameController: clientNameController,
            customContacts: widget.customContacts,
          ),
          16.ph,
          ClientAddressFormField(
              clientAddressController: clientAddressController),
          16.ph,
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
          Builder(
              builder: (context) {
                return NextButton(
                  onClick: () {
                    if (validate != null && validate == true) {
                      BlocProvider.of<ClientsBloc>(context).add(AddClientEvent(
                          isTrader ?? true,
                          clientNameController.text,
                          clientPhoneController.text,
                          clientAddressController.text.isEmpty ? null : clientAddressController.text,
                      ));
                      widget.moveForward(isTrader ?? true);
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
