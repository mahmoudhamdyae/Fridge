import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/reports/presentation/components/expenses_box.dart';

import '../../../core/services/services_locator.dart';
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
                'ssss ${AppStrings.egp}',
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
                    barGroups: barGroups,
                    gridData: const FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        16.ph,
        const ExpensesBox(expenses: 12.000),
      ],
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

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = getSmallStyle(
        color: AppColors.dark2,
        fontSize: 12.0
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = AppStrings.reportsTabDec;
        break;
      case 1:
        text = AppStrings.reportsTabNov;
        break;
      case 2:
        text = AppStrings.reportsTabOct;
        break;
      case 3:
        text = AppStrings.reportsTabSep;
        break;
      case 4:
        text = AppStrings.reportsTabAug;
        break;
      case 5:
        text = AppStrings.reportsTabJul;
        break;
      case 6:
        text = AppStrings.reportsTabJun;
        break;
      case 7:
        text = AppStrings.reportsTabMay;
        break;
      case 8:
        text = AppStrings.reportsTabApr;
        break;
      case 9:
        text = AppStrings.reportsTabMar;
        break;
      case 10:
        text = AppStrings.reportsTabFeb;
        break;
      case 11:
        text = AppStrings.reportsTabJan;
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

  FlTitlesData get titlesData => FlTitlesData(
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

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 8,
          color: const Color(0xffB7C3DB),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 10,
          color: const Color(0xff000A4F),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 14,
          color: const Color(0xffD8E8F8),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 15,
          color: const Color(0xffEE8626),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: 13,
          color: const Color(0xff000A4F),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: 10,
          color: const Color(0xffFECC5E),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xffD8E8F8),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 7,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xffB7C3DB),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 8,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xff000A4F),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 9,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xffD8E8F8),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 10,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xffEE8626),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 11,
      barRods: [
        BarChartRodData(
          toY: 16,
          color: const Color(0xff000A4F),
          borderRadius: BorderRadius.zero,
          width: 20,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];
}
