import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../data/models/amount_paid.dart';

class SahbTable extends StatelessWidget {

  final AmountPaid amounts;
  const SahbTable({super.key, required this.amounts});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        // First Row of the table
        Row(
          children: [
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
          itemCount: amounts.allTrashed?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                child: Row(
                  children: [
                    // المنتج
                    Expanded(
                        child: Text(
                          amounts.allTrashed?[index].trashedStore?.product ?? '',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // رقم العنبر
                    Expanded(
                        child: Text(
                          amounts.allTrashed?[index].trashedStore?.partName.toString() ?? '',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // مكان التخزين
                    Expanded(
                        child: Text(
                          '${amounts.allTrashed?[index].trashedStore?.xAxies} * ${amounts.allTrashed?[index].trashedStore?.xAxies}',
                          textAlign: TextAlign.center,
                          style: getSmallStyle(fontSize: 10.0),
                        )
                    ),
                    // التاريخ
                    Expanded(
                        child: Text(
                          amounts.allTrashed?[index].date ?? '',
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
