import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/typedefs.dart';
import 'custom_text.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.title,
    this.isPassword = false,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final ValidatorFunction validator;
  final bool? isPassword;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.ph,
        CustomText(
          widget.title ?? "",
          textStyle: context.textTheme.titleMedium,
        ),
        10.ph,
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onSaved: widget.onSaved,
          cursorColor: AppColors.teal,
          obscureText: widget.isPassword ?? false,
          style: GoogleFonts.montserrat(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorStyle: GoogleFonts.montserrat(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.teal)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.teal)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.teal)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}