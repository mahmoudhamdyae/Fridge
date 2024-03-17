import 'package:flutter/cupertino.dart';

class ErrorScreen extends StatelessWidget {

  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   ImageAssets.error,
            //   height: AppSize.s190,
            // ),
            const SizedBox(height: 40,),
            Text(
              error.replaceFirst('Exception: ', ''),
              // style: getLargeStyle(
              //   color: ColorManager.error,
              // ),
            ),
          ],
        )
    );
  }
}
