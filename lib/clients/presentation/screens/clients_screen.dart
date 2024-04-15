import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/clients/presentation/screens/add_client_tabs_screen.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/home/presentation/screens/main_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../components/add_client_button.dart';
import '../components/client_details_button.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late ClientsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ClientsBloc>();
    bloc.add(GetClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientsBloc, ClientsState>(
      listener: (context, state) {
        if (state.addClientState == RequestState.loaded) {
          NavigateUtil().navigateToScreen(context, const MainScreen(showSnackBar: true,));
        }
      },
      child: SafeArea(
          child: Scaffold(
            body: Container(
              height: context.height,
              padding: getMainPadding(context),
              decoration: getMainDecoration(),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const MainAppBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [AddClientButton(onClick: () {
                      NavigateUtil().navigateToScreen(
                        context,
                        BlocProvider.value(
                          value: instance<ClientsBloc>(),
                          child: const AddClientTabsScreen(),
                        ),
                      );
                    },), const ClientDetailsButton()],
                  ),
                  24.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      decoration: getFilledTextFieldDecoration(
                        hint: AppStrings.homeScreenSearchHint,
                        radius: 20.0,
                        prefixIcon: Icons.search,
                        textStyle: getSmallStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeightManager.medium,
                            color: AppColors.dark2
                        )
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        bloc.add(SearchClientsEvent(value));
                      },
                    ),
                  ),
                  16.ph,
                  BlocBuilder<ClientsBloc, ClientsState>(
                    builder: (context, state) {
                      if (state.getClientsState == RequestState.loading) {
                        return const LoadingScreen();
                      } else if (state.getClientsState == RequestState.error) {
                        return ErrorScreen(error: state.getClientsErrorMessage);
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.searchedClients.length,
                        itemBuilder: (BuildContext context, int index) {
                          Client client = state.searchedClients[index];
                          return Card(
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
                                    height: 80,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
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
                                            ? AppStrings
                                            .addClientScreenDealerWithQ
                                            : AppStrings
                                            .addClientScreenTraderWithQ,
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
