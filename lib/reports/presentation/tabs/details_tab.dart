import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/reports/presentation/bloc/reports_bloc.dart';

import '../../../core/components/states/error_screen.dart';
import '../../../core/components/states/loading_screen.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class DetailsTab extends StatefulWidget {
  const DetailsTab({super.key});

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {

  late final ReportsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ReportsBloc>();
    bloc.add(GetAnalysisEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
                  AppStrings.detailsTabDate,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0
                  ),
                )
            ),
            Expanded(
                child: Text(
                  AppStrings.detailsTabProduct,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0
                  ),
                )
            ),
            Expanded(
                child: Text(
                  AppStrings.detailsTabDetails,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0
                  ),
                )
            ),
            Expanded(
                child: Text(
                  AppStrings.detailsTabPrice,
                  textAlign: TextAlign.center,
                  style: getSmallStyle(
                      fontSize: 14.0
                  ),
                )
            ),
          ],
        ),
        16.ph,
        BlocBuilder<ReportsBloc, ReportsState>(
          buildWhen: (previousState, currentState) =>
          currentState is GetAnalysisLoadingState ||
              currentState is GetAnalysisErrorState ||
              currentState is GetAnalysisLoadedState,
          builder: (BuildContext context, state) {
            if (state is GetAnalysisLoadingState) {
              return const LoadingScreen();
            } else if (state is GetAnalysisErrorState) {
              return ErrorScreen(error: state.errorMessage);
            } else if (state is GetAnalysisLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.analysis.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.all(16.0),
                      color: index % 2 == 0 ? const Color(0xffD9D9D9) : const Color(0xffEAEDF4),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                state.analysis[index].date ?? '',
                                textAlign: TextAlign.center,
                                style: getSmallStyle(fontSize: 10.0),
                              )
                          ),
                          Expanded(
                              child: Text(
                                state.analysis[index].product ?? '',
                                textAlign: TextAlign.center,
                                style: getSmallStyle(fontSize: 10.0),
                              )
                          ),
                          Expanded(
                              child: Text(
                                state.analysis[index].boxingType ?? '',
                                textAlign: TextAlign.center,
                                style: getSmallStyle(fontSize: 10.0),
                              )
                          ),
                          Expanded(
                              child: Text(
                                '${state.analysis[index].totalPrice ?? ''} ${AppStrings.egp}',
                                textAlign: TextAlign.center,
                                style: getSmallStyle(fontSize: 10.0),
                              )
                          ),
                        ],
                      )
                  );
                },
              );
            } else {
              return Container();
            }
          },)
      ],
    );
  }
}
