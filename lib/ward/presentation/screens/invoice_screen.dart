import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/components/print_button.dart';

import '../../../core/components/decorations.dart';

class InvoiceScreen extends StatefulWidget {

  final int storeId;
  const InvoiceScreen({super.key, required this.storeId});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  late WardsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<WardsBloc>();
    // bloc.add(); // todo add invoice event
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                32.ph,
                Text(
                  AppStrings.billScreenTitle,
                  style: getLargeStyle(
                    fontSize: 24.0
                  ),
                ),
                24.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.billScreenClientName,
                      style: getSmallStyle(),
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.billScreenClientDate,
                          style: getSmallStyle(),
                        ),
                        Text(
                          '12/05/2024',
                          style: getSmallStyle(
                            color: const Color(0xff5D5D5D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    Text(
                      'على محمود السيد',
                      style: getLargeStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    4.pw,
                    Text(
                      '(تاجر)',
                      style: getSmallStyle(
                        color: const Color(0xff5A5A5A)
                      ),
                    )
                  ],
                ),
                32.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenProduct,
                      style: getSmallStyle(),
                    ),
                    Text(
                      'بطاطس',
                      style: getSmallStyle(
                        color: const Color(0xff6B6B6B),
                      ),
                    )
                  ],
                ),
                24.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenQuantity,
                      style: getSmallStyle(),
                    ),
                    Text(
                      '1 طن',
                      style: getSmallStyle(
                        color: const Color(0xff6B6B6B),
                      ),
                    )
                  ],
                ),
                24.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.billScreenWardsNumber,
                          style: getSmallStyle(),
                        ),
                        Text(
                          '1',
                          style: getSmallStyle(
                            color: const Color(0xff6B6B6B),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.billScreenWardArea,
                          style: getSmallStyle(),
                        ),
                        Text(
                          '(3 * 4)',
                          style: getSmallStyle(
                            color: const Color(0xff6B6B6B),
                          ),
                        ),
                        context.dynamicWidth(.2).pw,
                      ],
                    ),
                  ],
                ),
                24.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenStoreType,
                      style: getSmallStyle(),
                    ),
                    Text(
                      'شكاير',
                      style: getSmallStyle(
                        color: const Color(0xff6B6B6B),
                      ),
                    )
                  ],
                ),
                24.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenStorePlace,
                      style: getSmallStyle(),
                    ),
                    Text(
                      'ثلاجة 5',
                      style: getSmallStyle(
                        color: const Color(0xff6B6B6B),
                      ),
                    )
                  ],
                ),
                24.ph,
                const Divider(
                  height: 1.0,
                  color: Color(0xffC3C3C3),
                ),
                16.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenPrice,
                      style: getSmallStyle(),
                    ),
                    Text(
                      '1000 ${AppStrings.egp}',
                      style: getSmallStyle(),
                    )
                  ],
                ),
                16.ph,
                Row(
                  children: [
                    Text(
                      AppStrings.billScreenTotalPrice,
                      style: getSmallStyle(),
                    ),
                    Text(
                      '5000 ${AppStrings.egp}',
                      style: getSmallStyle(),
                    )
                  ],
                ),
                24.ph,
                PrintButton(onTap: () {}),
                const BackButton2()
              ],
            ),
          ),
        )
    );
  }
}
