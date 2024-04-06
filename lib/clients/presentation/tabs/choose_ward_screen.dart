import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/tabs/choose_ward_first_screen.dart';
import 'package:fridge/clients/presentation/tabs/choose_ward_second_screen.dart';

class ChooseWardScreen extends StatefulWidget {

  final String productType;
  const ChooseWardScreen({super.key, required this.productType});

  @override
  State<ChooseWardScreen> createState() => _ChooseWardScreenState();
}

class _ChooseWardScreenState extends State<ChooseWardScreen> {

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return currentPage == 0 ? ChooseWardFirstScreen(goNext: () {
      setState(() {
        currentPage = 1;
      });
    }) : ChooseWardSecondScreen(productType: widget.productType,);
  }
}
