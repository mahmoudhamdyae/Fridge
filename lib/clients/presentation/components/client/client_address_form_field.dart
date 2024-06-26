import 'package:flutter/material.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../../core/resources/app_strings.dart';

class ClientAddressFormField extends StatelessWidget {

  final TextEditingController clientAddressController;
  const ClientAddressFormField({
    super.key,
    required this.clientAddressController,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: getFilledTextFieldDecorationWithLabel(
        label: AppStrings.addClientScreenClientAddressLabel,
      ),
      controller: clientAddressController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
    );
  }
}