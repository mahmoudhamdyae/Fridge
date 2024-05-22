import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class AllTransactionsTable extends StatelessWidget {
  const AllTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        // First Row of the table
        Row(
          children: [
            // المبلغ المدفوع
            Expanded(
                child: Text(
                  AppStrings.addClientScreenTableAmountPaid,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0,
                      color: AppColors.colorRamps3
                  ),
                )
            ),
            // التاريخ
            Expanded(
                child: Text(
                  AppStrings.addClientScreenTableDate,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0,
                      color: AppColors.colorRamps3
                  ),
                )
            ),
            // المنتج
            Expanded(
                child: Text(
                  AppStrings.addClientScreenTableProduct,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0,
                      color: AppColors.colorRamps3
                  ),
                )
            ),
            // رقم العنبر
            Expanded(
                child: Text(
                  AppStrings.addClientScreenTableWardName,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0,
                      color: AppColors.colorRamps3
                  ),
                )
            ),
            // مكان التخزين
            Expanded(
                child: Text(
                  AppStrings.addClientScreenTablePlace,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0,
                      color: AppColors.colorRamps3
                  ),
                )
            ),
          ],
        ),
        16.ph,
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 13,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                child: Row(
                  children: [
                    // المبلغ المدفوع
                    Expanded(
                        child: Text(
                          '10',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // التاريخ
                    Expanded(
                        child: Text(
                          '1-3-2024',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // المنتج
                    Expanded(
                        child: Text(
                          'بطاطس',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // رقم العنبر
                    Expanded(
                        child: Text(
                          'عنبر 1',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // مكان التخزين
                    Expanded(
                        child: Text(
                          '3 * 4',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                  ],
                )
            );
          },
        ),
      ],
    );
  }
}
