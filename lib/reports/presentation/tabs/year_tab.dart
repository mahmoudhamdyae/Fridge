import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/reports/data/models/year.dart';

import '../../../core/components/states/error_screen.dart';
import '../../../core/components/states/loading_screen.dart';
import '../../../core/services/services_locator.dart';
import '../bloc/reports_bloc.dart';
import '../components/expenses_box.dart';

class YearTab extends StatefulWidget {
  const YearTab({super.key});

  @override
  State<YearTab> createState() => _YearTabState();
}

class _YearTabState extends State<YearTab> {

  late final ReportsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ReportsBloc>();
    bloc.add(GetYearEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      buildWhen: (previous, current) =>
      current is GetYearLoadingState ||
          current is GetYearErrorState ||
          current is GetYearLoadedState,
      builder: (context, state) {
        if (state is GetYearLoadingState) {
          return const LoadingScreen();
        } else if (state is GetYearErrorState) {
          return ErrorScreen(error: state.errorMessage);
        } else if (state is GetYearLoadedState) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              16.ph,
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.years.totalIncome ?? 0} ${AppStrings.egp}',
                      style: getLargeStyle(
                          fontSize: 20, color: const Color(0xff193263)),
                    ),
                    Text(
                      AppStrings.reportsTabTotalPrice,
                      style: getSmallStyle(
                        color: const Color(0xff6B6B6B),
                        fontSize: 12,
                      ),
                    ),
                    16.ph,
                    SizedBox(
                      height: 250,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: context.width,
                          child: BarChart(
                            BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData(state),
                              borderData: borderData,
                              barGroups: barGroups(state),
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.start,
                              maxY: getMaxCount(state),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              16.ph,
              ExpensesBox(
                expenses: state.years.totalExpense,
                totalIncome: state.years.totalIncome,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta, GetYearLoadedState state) {
    TextStyle style = getSmallStyle(color: AppColors.dark2, fontSize: 12.0);
    YearChart year = state.years.chart![value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 15,
      angle: 30,
      child: Text(year.month ?? '', style: style),
    );
  }

  FlTitlesData titlesData(GetYearLoadedState state) => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 60,
        getTitlesWidget: (double value, TitleMeta meta) =>
            getTitles(value, meta, state),
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> barGroups(GetYearLoadedState state) =>
      List.generate(state.years.chart!.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: state.years.chart?[index].count?.toDouble() ?? 0.0,
              color: AppColors.getRandomColor(),
              borderRadius: BorderRadius.zero,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  double getMaxCount(GetYearLoadedState state) {
    int max = 0;
    for (var element in state.years.chart ?? []) {
      if ((element.count ?? 0) > max) {
        max = element.count!;
      }
    }
    return max.toDouble();
  }
}
