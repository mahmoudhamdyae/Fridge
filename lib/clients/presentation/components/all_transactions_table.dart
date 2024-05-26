import 'package:flutter/material.dart';
import 'package:fridge/clients/data/models/amount_paid.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class AllTransactionsTable extends StatelessWidget {

  final int paid;
  final int remain;
  final AmountPaid amounts;

  const AllTransactionsTable({
    super.key,
    required this.paid,
    required this.remain,
    required this.amounts
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    AppStrings.addClientScreenTotalPaid,
                    style: getSmallStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '$paid ${AppStrings.egp}',
                    style: getSmallStyle(
                        fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  AppStrings.addClientScreenTotalRemain,
                  style: getSmallStyle(
                      fontSize: 12,
                  ),
                ),
                Text(
                  '$remain ${AppStrings.egp}',
                  style: getSmallStyle(
                      fontSize: 12,
                  ),
                )
              ],
            ),
          ],
        ),
        16.ph,
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
          ],
        ),
        16.ph,
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: amounts.allAmount?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                child: Row(
                  children: [
                    // المبلغ المدفوع
                    Expanded(
                        child: Text(
                          (amounts.allAmount ?? [])[index].amountPaid.toString(),
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // التاريخ
                    Expanded(
                        child: Text(
                          amounts.allAmount?[index].date ?? '',
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
