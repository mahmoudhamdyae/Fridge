import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/components/add_more_button.dart';
import 'package:fridge/clients/presentation/screens/client_invoice_screen.dart';
import 'package:fridge/core/components/dialogs/del_dialog.dart';
import 'package:fridge/core/components/dialogs/error_dialog.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../domain/entities/client.dart';

class ClientItem extends StatelessWidget {

  final Client client;

  const ClientItem({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ClientsBloc>(context).add(
            GetClientInvoiceEvent(client.id ?? -1));
        NavigateUtil().navigateToScreen(context, BlocProvider.value(
            value: instance<ClientsBloc>(),
            child: BlocProvider.value(value: instance<WardsBloc>(),
                child: const ClientInvoiceScreen())
        ));
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 8,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(10.0)),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 185,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff2D5AAF),
                        Color(0xffEE8626),
                      ],
                    )),
              ),
              16.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.ph,
                  SizedBox(
                    width: context.dynamicWidth(.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          client.name ?? '',
                          style: getSmallStyle(
                            fontWeight:
                            FontWeightManager.medium,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              client.phone ?? '',
                              style: getSmallStyle(
                                fontWeight:
                                FontWeightManager.medium,
                                fontSize: 14,
                                color: const Color(0xff6B6B6B),
                              ),
                            ),
                            BlocListener<ClientsBloc, ClientsState>(
                              listenWhen: (previous, current) =>
                                  current.delClientState == RequestState.error ||
                                  current.delClientState == RequestState.loaded,
                              listener: (context, state) {
                                if (state.delClientState == RequestState.error) {
                                  NavigateUtil().navigateUp(context);
                                  showError(context, state.delClientErrorMessage, () {});
                                } else if (state.delClientState == RequestState.loaded) {
                                  NavigateUtil().navigateUp(context);
                                }
                              },
                              child: IconButton(
                                  onPressed: () {
                                    showDelDialog(
                                        context: context,
                                        text: AppStrings.delDialogClientText,
                                        action: () {
                                          BlocProvider.of<ClientsBloc>(context)
                                              .add(DelClientEvent(client.id ?? -1));
                                        });
                                  },
                                  icon: const Icon(Icons.delete)
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  client.address == null ? Container() : Text(
                    client.address ?? '',
                    style: getSmallStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 14,
                      color: const Color(0xff525252),
                    ),
                  ),
                  8.ph,
                  SizedBox(
                    width: context.dynamicWidth(.75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // المبلغ المدفوع
                        Row(
                          children: [
                            Text(
                              AppStrings.clientsScreenAmountPaid,
                              style: getSmallStyle(),
                            ),
                            Text(
                              '${client.amountPaid} ${AppStrings.egp}',
                              style: getSmallStyle(
                                fontWeight:
                                FontWeightManager.medium,
                                fontSize: 14,
                                color: const Color(0xff6B6B6B),
                              ),
                            ),
                          ],
                        ),
                        // المبلغ المتبقى
                        Row(
                          children: [
                            Text(
                              AppStrings.clientsScreenAmountRemain,
                              style: getSmallStyle(),
                            ),
                            Text(
                              '${client.amountRemain} ${AppStrings.egp}',
                              style: getSmallStyle(
                                fontWeight:
                                FontWeightManager.medium,
                                fontSize: 14,
                                color: const Color(0xff6B6B6B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  8.ph,
                  // عدد الأطنان
                  client.bags == 0 ? Row(
                    children: [
                      Text(
                        AppStrings.clientsScreenTons,
                        style: getSmallStyle(),
                      ),
                      Text(
                        client.tons.toString(),
                        style: getSmallStyle(
                          fontWeight:
                          FontWeightManager.medium,
                          fontSize: 14,
                          color: const Color(0xff6B6B6B),
                        ),
                      ),
                    ],
                  ) :
                  // عدد الشكاير
                  Row(
                    children: [
                      Text(
                        AppStrings.clientsScreenBags,
                        style: getSmallStyle(),
                      ),
                      Text(
                        client.bags.toString(),
                        style: getSmallStyle(
                          fontWeight:
                          FontWeightManager.medium,
                          fontSize: 14,
                          color: const Color(0xff6B6B6B),
                        ),
                      ),
                    ],
                  ),
                  12.ph,
                  SizedBox(
                      width: context.dynamicWidth(.8),
                      child: AddMoreButton(client: client,)
                  ),
                  8.ph,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
