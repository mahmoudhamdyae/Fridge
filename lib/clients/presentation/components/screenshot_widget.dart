import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../data/models/client_invoice.dart';

class ScreenshotWidget extends StatelessWidget {

  final List<ClientInvoiceStores> stores;
  final String name;
  const ScreenshotWidget({super.key, required this.stores, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: getSmallStyle(
                    color: const Color(0xff5D5D5D),
                  ),
                ),
              ],
            ),
          ],
        ),
        8.ph,
        Text(
          name,
          style: getLargeStyle(
            fontSize: 22.0,
          ),
        ),
        32.ph,
        Column(children: stores.map((store) {
          return InkWell(
            onTap: () {
              // todo navigate to ward
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Column(
                  // shrinkWrap: true,
                  // physics: const ClampingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.billScreenProduct,
                              style: getSmallStyle(),
                            ),
                            Text(
                              store.product ?? '',
                              style: getSmallStyle(
                                color: const Color(0xff6B6B6B),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.billScreenQuantity,
                              style: getSmallStyle(),
                            ),
                            Text(
                              '${store.totalWeight} ${store.unit}',
                              style: getSmallStyle(
                                color: const Color(0xff6B6B6B),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    24.ph,
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppStrings
                                      .billScreenWardsNumber,
                                  style: getSmallStyle(),
                                ),
                                Text(
                                  (store.quantity).toString(),
                                  style: getSmallStyle(
                                    color:
                                    const Color(0xff6B6B6B),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.billScreenStoreType,
                              style: getSmallStyle(),
                            ),
                            Text(
                              store.boxing ?? '',
                              style: getSmallStyle(
                                color: const Color(0xff6B6B6B),
                              ),
                            )
                          ],
                        ),
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
                          AppStrings.billScreenTotalPrice,
                          style: getSmallStyle(),
                        ),
                        Text(
                          '${store.price} ${AppStrings.egp}',
                          style: getSmallStyle(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),),
      ],
    );
  }
}
