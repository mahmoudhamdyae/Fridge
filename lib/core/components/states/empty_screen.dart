import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {

  final String emptyString;
  const EmptyScreen({super.key, required this.emptyString});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   ImageAssets.empty,
          //   height: AppSize.s190,
          // ),
          const SizedBox(height: 40,),
          Text(
            emptyString,
            // style: getLargeStyle(),
          ),
        ],
      ),
    );
  }
}
