import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/reports/presentation/components/expenses_box.dart';

import '../../../core/components/states/error_screen.dart';
import '../../../core/components/states/loading_screen.dart';
import '../../../core/services/services_locator.dart';
import '../../data/models/month.dart';
import '../bloc/reports_bloc.dart';

class MonthTab extends StatefulWidget {
  const MonthTab({super.key});

  @override
  State<MonthTab> createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {
  late final ReportsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ReportsBloc>();
    bloc.add(GetMonthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      buildWhen: (previous, current) =>
          current is GetMonthLoadingState ||
          current is GetMonthErrorState ||
          current is GetMonthLoadedState,
      builder: (context, state) {
        if (state is GetMonthLoadingState) {
          return const LoadingScreen();
        } else if (state is GetMonthErrorState) {
          return ErrorScreen(error: state.errorMessage);
        } else if (state is GetMonthLoadedState) {
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
                      '${state.months.totalIncome ?? 0} ${AppStrings.egp}',
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
                    32.ph,
                    SizedBox(
                      height: 250,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: context.width * 2,
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
                firstLabel:  AppStrings.reportsTabExpenses,
                firstValue: '${state.months.totalExpense} ${AppStrings.egp}',
                secondLabel: AppStrings.reportsTabProfits,
                secondValue: '${(state.months.totalIncome ?? 0) - (state.months.totalExpense ?? 0)} ${AppStrings.egp}',
              ),
              16.ph,
              ExpensesBox(
                firstLabel:  AppStrings.reportsTabAmountPaid,
                firstValue: '${state.months.amountPaid ?? 0} ${AppStrings.egp}',
                secondLabel: AppStrings.reportsTabAmountRemain,
                secondValue: '${state.months.amountRemain ?? 0} ${AppStrings.egp}',
              ),
              16.ph,
              ExpensesBox(
                firstLabel:  AppStrings.reportsTabTons,
                firstValue: '${state.months.ton ?? 0} ${AppStrings.ton}',
                secondLabel: AppStrings.reportsTabBags,
                secondValue: '${state.months.bags ?? 0} ${AppStrings.bags}',
              ),
              16.ph,
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

  Widget getTitles(double value, TitleMeta meta, GetMonthLoadedState state) {
    TextStyle style = getSmallStyle(color: AppColors.dark2, fontSize: 12.0);
    MonthChart month = state.months.chart![value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 15,
      angle: 30,
      child: Text(month.date ?? '', style: style),
    );
  }

  FlTitlesData titlesData(GetMonthLoadedState state) => FlTitlesData(
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

  List<BarChartGroupData> barGroups(GetMonthLoadedState state) =>
      List.generate(state.months.chart!.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: state.months.chart?[index].count?.toDouble() ?? 0.0,
              color: AppColors.getRandomColor(),
              borderRadius: BorderRadius.zero,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  double getMaxCount(GetMonthLoadedState state) {
    int max = 0;
    for (var element in state.months.chart ?? []) {
      if ((element.count ?? 0) > max) {
        max = element.count!;
      }
    }
    return max.toDouble();
  }
}
