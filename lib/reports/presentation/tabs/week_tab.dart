import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/states/error_screen.dart';
import 'package:fridge/core/components/states/loading_screen.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/reports/presentation/bloc/reports_bloc.dart';
import 'package:fridge/reports/presentation/components/expenses_box.dart';

class WeekTab extends StatefulWidget {
  const WeekTab({super.key});

  @override
  State<WeekTab> createState() => _WeekTabState();
}

class _WeekTabState extends State<WeekTab> {

  late final ReportsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = instance<ReportsBloc>();
    bloc.add(GetWeekEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      buildWhen: (previous, current) =>
      current is GetWeekLoadingState ||
      current is GetWeekErrorState ||
      current is GetWeekLoadedState,
      builder: (context, state) {
        if (state is GetWeekLoadingState) {
          return const LoadingScreen();
        } else if (state is GetWeekErrorState) {
          return ErrorScreen(error: state.errorMessage);
        } else if (state is GetWeekLoadedState) {
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
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.weeks.totalIncome} ${AppStrings.egp}',
                      style: getLargeStyle(
                          fontSize: 20,
                          color: const Color(0xff193263)
                      ),
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
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          barTouchData: barTouchData,
                          titlesData: titlesData,
                          borderData: borderData,
                          barGroups: barGroups(state),
                          gridData: const FlGridData(show: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: getMaxCount(state),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              16.ph,
              ExpensesBox(expenses: double.parse(state.weeks.totalExpense ?? '0').toInt()),
            ],
          );
        }
        return Container();
      },
    );
  }

  BarTouchData get barTouchData =>
      BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,) {
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

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = getSmallStyle(
        color: AppColors.dark2,
        fontSize: 12.0
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = AppStrings.reportsTabFri;
        break;
      case 1:
        text = AppStrings.reportsTabThu;
        break;
      case 2:
        text = AppStrings.reportsTabWed;
        break;
      case 3:
        text = AppStrings.reportsTabTue;
        break;
      case 4:
        text = AppStrings.reportsTabMon;
        break;
      case 5:
        text = AppStrings.reportsTabSun;
        break;
      case 6:
        text = AppStrings.reportsTabSat;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
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

  FlBorderData get borderData =>
      FlBorderData(
        show: false,
      );

  List<BarChartGroupData> barGroups(GetWeekLoadedState state) =>
      List.generate(state.weeks.chart?.length ?? 0, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: state.weeks.chart?[index].count?.toDouble() ?? 0.0,
              color: AppColors.getRandomColor(),
              borderRadius: BorderRadius.zero,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  double getMaxCount(GetWeekLoadedState state) {
    int max = 0;
    for (var element in state.weeks.chart ?? []) {
      if ((element.count ?? 0) > max) {
        max = element.count!;
      }
    }
    return max.toDouble();
  }
}
