import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/clients/presentation/components/send_button.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/components/print_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/components/decorations.dart';
import '../../../core/components/states/error_screen.dart';
import '../../../core/components/states/loading_screen.dart';
import '../../../core/enums/request_state.dart';
import '../../data/models/client_invoice.dart';
import '../bloc/clients_bloc.dart';
import '../components/screenshot_widget.dart';

class ClientInvoiceScreen extends StatefulWidget {

  const ClientInvoiceScreen({super.key});

  @override
  State<ClientInvoiceScreen> createState() => _ClientInvoiceScreenState();
}

class _ClientInvoiceScreenState extends State<ClientInvoiceScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  List<ClientInvoiceStores> stores = [];
  String name = '';

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
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      NavigateUtil().navigateUp(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                // 16.pw,
                Text(
                  AppStrings.billScreenTitle,
                  style: getLargeStyle(fontSize: 24.0),
                ),
              ],
            ),
            24.ph,
            Screenshot(
              controller: screenshotController,
                child: BlocBuilder<ClientsBloc, ClientsState>(
                  buildWhen: (previousState, state) =>
                  state.getInvoiceState != RequestState.init,
                  builder: (context, state) {
                    if (state.getInvoiceState == RequestState.loading) {
                      return const LoadingScreen();
                    } else if (state.getInvoiceState == RequestState.loading) {
                      return ErrorScreen(error: state.getClientInvoiceErrorMessage);
                    } else if (state.getInvoiceState == RequestState.loaded) {
                      stores = state.invoice.stores ?? [];
                      name = state.invoice.name ?? '';
                      return ScreenshotWidget(
                        stores: stores,
                        name: name,
                        isScreenshot: false,
                      );
                    }
                    return Container();
                  },
                )
            ),
            24.ph,
            SendButton(onTap: () {
              screenshotController.captureFromLongWidget(
                InheritedTheme.captureAll(
                    context,
                    Material(
                      child: Builder(
                          builder: (context) {
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ScreenshotWidget(stores: stores, name: name),
                                ));
                          }
                      ),
                    ),
                  ),
                  delay: const Duration(milliseconds: 100),
                  context: context,
              ).then((Uint8List? image) {
                Share.shareXFiles([XFile.fromData(image!, mimeType: "png")]);
              });
            }),
            24.ph,
            PrintButton(onTap: () {}),
            const BackButton2()
          ],
        ),
      ),
    ));
  }
}
