import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../domain/entities/store.dart';
import '../bloc/wards_bloc.dart';
import '../screens/invoice_screen.dart';
import 'client_details_button.dart';

Future<dynamic> buildShowModalBottomSheet(BuildContext context, List<Store> stores) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            16.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      NavigateUtil().navigateUp(context);
                    },
                    icon: const Icon(Icons.close)),
                Expanded(child: Container()),
                Image.asset(
                  AppAssets.package,
                  width: 60,
                  height: 60,
                ),
                Expanded(child: Container()),
                16.pw,
              ],
            ),
            16.ph,
            const Divider(
              height: 1,
              color: AppColors.grey,
            ),
            16.ph,
            SizedBox(
              height: context.dynamicHeight(.4),
              child: ListView(
                children: [
                  ...List.generate(
                      stores.length, (index) {
                    StoreCustomer? customer = stores[index].customer;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.productDialogClientName,
                              style: getSmallStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              customer?.name ?? '',
                              style: getSmallStyle(
                                fontSize: 18,
                              ),
                            ),
                            8.pw,
                            Text(
                              customer?.type == 0 ? AppStrings.addClientScreenTraderWithQ : AppStrings.addClientScreenDealerWithQ,
                              style: getSmallStyle(
                                color: const Color(0xff6B6B6B),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        8.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppStrings.productDialogProduct,
                                  style: getSmallStyle(),
                                ),
                                Text(
                                  stores[index].product ?? '',
                                  style: getSmallStyle(
                                    color: const Color(0xff6B6B6B),
                                  ),
                                ),
                              ],
                            ),
                            0.pw,
                            Row(
                              children: [
                                Text(
                                  AppStrings.productDialogQuantity,
                                  style: getSmallStyle(),
                                ),
                                Text(
                                  '${stores[index].totalWeight} ${stores[index].unit}',
                                  style: getSmallStyle(
                                    color: const Color(0xff6B6B6B),
                                  ),
                                ),
                              ],
                            ),
                            0.pw,
                          ],
                        ),
                        16.ph,
                        SizedBox(
                          width: context.dynamicWidth(.8),
                          child: SheetClientDetailsButton(onTap: () {
                            NavigateUtil().navigateUp(context);
                            NavigateUtil().navigateToScreen(
                              context,
                              BlocProvider.value(
                                value: instance<WardsBloc>(),
                                child: InvoiceScreen(
                                  storeId: stores[index].id ?? -1,
                                ),
                              ),
                            );
                          }),
                        ),
                        16.ph,
                        const Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),
                        16.ph,
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}