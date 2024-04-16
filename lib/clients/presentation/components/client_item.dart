import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/components/add_more_button.dart';
import 'package:fridge/clients/presentation/screens/client_invoice_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/services/services_locator.dart';

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
        BlocProvider.of<ClientsBloc>(context).add(GetClientInvoiceEvent(client.id ?? -1));
        NavigateUtil().navigateToScreen(context, BlocProvider.value(
            value: instance<ClientsBloc>(),
            child: const ClientInvoiceScreen()
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
                height: 140,
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
                    width: context.width - 90,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          client.name ?? '',
                          style: getSmallStyle(
                            fontWeight:
                            FontWeightManager.medium,
                          ),
                        ),
                        Text(
                          client.phone ?? '',
                          style: getSmallStyle(
                            fontWeight:
                            FontWeightManager.medium,
                            fontSize: 14,
                            color: const Color(0xff6B6B6B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    client.type == 0
                        ? AppStrings.addClientScreenDealerWithQ
                        : AppStrings.addClientScreenTraderWithQ,
                    style: getSmallStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 12,
                      color: const Color(0xff666666),
                    ),
                  ),
                  8.ph,
                  Text(
                    client.address ?? '',
                    style: getSmallStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 14,
                      color: const Color(0xff525252),
                    ),
                  ),
                  8.ph,
                  SizedBox(
                      width: context.width - 90,
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
