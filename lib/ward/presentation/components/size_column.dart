import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/ward/presentation/components/size_form_field.dart';

class SizeColumn extends StatefulWidget {

  final String text;
  final Function(String) onChanged;
  const SizeColumn({super.key, required this.text, required this.onChanged});

  @override
  State<SizeColumn> createState() => _SizeColumnState();
}

class _SizeColumnState extends State<SizeColumn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: getSmallStyle(
            fontWeight: FontWeightManager.medium,
            fontSize: 17,
          ),
        ),
        16.ph,
        SizedBox(
            width: (context.width / 3),
            height: 45,
            child: Form(key: _formKey, child: SizeFormField(sizeController: sizeController))
        )
      ],
    );
  }
}
