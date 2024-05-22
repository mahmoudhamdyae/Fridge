import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/components/all_transactions_table.dart';
import 'package:fridge/clients/presentation/components/sahb_table.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {

  bool? isPaidShown;
  bool? isSahbShown;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            shape: const CircleBorder(),
            backgroundColor: AppColors.colorRamps3,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(canNavigateUp: true,),
                // تاريخ المعاملات المالية
                Container(
                  width: double.infinity,
                  color: AppColors.colorRamps3,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.addClientScreeShowAllTransactions1,
                        style: getSmallStyle(
                          color: AppColors.white
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (isPaidShown == null || isPaidShown == false) {
                              setState(() {
                                isPaidShown = true;
                              });
                            } else {
                              setState(() {
                                isPaidShown = null;
                              });
                            }
                          },
                          icon: Icon(
                            isPaidShown == true ? Icons.expand_less : Icons.expand_more,
                            color: AppColors.white,
                          )
                      )
                    ],
                  ),
                ),
                isPaidShown == true ? const AllTransactionsTable() : Container(),
                // تاريخ السحب
                Container(
                  width: double.infinity,
                  color: AppColors.colorRamps3,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.addClientScreeShowAllTransactions2,
                        style: getSmallStyle(
                            color: AppColors.white
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (isSahbShown == null || isSahbShown == false) {
                              setState(() {
                                isSahbShown = true;
                              });
                            } else {
                              setState(() {
                                isSahbShown = null;
                              });
                            }
                          },
                          icon: Icon(
                            isSahbShown == true ? Icons.expand_less : Icons.expand_more,
                            color: AppColors.white,
                          )
                      )
                    ],
                  ),
                ),
                isSahbShown == true ? const SahbTable() : Container(),
              ],
            ),
          ),
        )
    );
  }
}
