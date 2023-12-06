import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/fl_chart_graph_data.dart';
import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/yearly_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  YearlyData yearlyDataModel;
  BarGraph({super.key, required this.yearlyDataModel});

  @override
  Widget build(BuildContext context) {
    YearlyData yearlyDataModel = this.yearlyDataModel;
    final yearlyUsedUnitData = yearlyDataModel.yearlyUsedUnitData();
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Month VS Total tk", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BarChart(
              BarChartData(
                maxY: yearlyDataModel.maxYearlyUsedUnit(),
                minY: 0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.grey.shade300
                  )
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles( sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles( sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles( sideTitles: 
                    SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTitles,
                      reservedSize: 42
                      )
                    ),
                ),
                
                //groupsSpace: 4,
                barGroups: yearlyUsedUnitData.
                    map((individualBarData) => 
                      BarChartGroupData(
                        barsSpace: 50,
                        x: integerValueOfMonth(individualBarData.month),
                        barRods: [
                          BarChartRodData(
                            fromY: 0,
                            toY: individualBarData.value,
                            width: 30,
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(3),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              color: Colors.grey.shade300,
                              toY: yearlyDataModel.maxYearlyUsedUnit()
                            )
                          )
                        ]
                      )).toList(),
              )
            ),
          ),
        ),
      ],
    );
  }
  int integerValueOfMonth(String month){
    final List<String> allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  for(int index =0; index<12; index++){
    if(month==allMonths[index])return index;
  }
  return 0;
  }
  Widget getBottomTitles(double value, TitleMeta meta){
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    final List<String> allMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  for(int index =0; index<12; index++){
    if(value.toInt()==index)return SideTitleWidget(axisSide: meta.axisSide, fitInside: SideTitleFitInsideData(enabled: true, axisPosition: meta.axisPosition, parentAxisSize: meta.parentAxisSize, distanceFromEdge: 0),  child: Text(allMonths[index], style: style,));
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: Text(allMonths[0], style: style,));

  }
}