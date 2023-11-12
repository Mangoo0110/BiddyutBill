import 'dart:math';

import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/fl_chart_graph_data.dart';

class YearlyData{
  Map<String,MonthlyRecord?> records;
  YearlyData({required this.records});

  List<IndividualBarData> yearlyUsedUnitData()
  {
    List<IndividualBarData>yearlyUsedUnits = [];
    records.forEach((key, value) => yearlyUsedUnits.add(IndividualBarData(month: key, value: value==null? 0 : value.usedunit)));
    return yearlyUsedUnits;
  }

  List<IndividualBarData> yearlyTotalElectricCostData()
  {
    List<IndividualBarData> yearlyUnitCost = [];
    records.forEach((key, value) => yearlyUnitCost.add(IndividualBarData(month: key, value: value==null? 0 : value.finaltotalTk)));
    return yearlyUnitCost;
  }

  double maxYearlyCost()
  {
    double maxTotalTk = 0;
    records.forEach((key, value) => maxTotalTk = max((value != null)? value.finaltotalTk : 0, maxTotalTk));
    return maxTotalTk;
  }

  double maxYearlyUsedUnit()
  {
    double maxUsedUnit = 0;
    records.forEach((key, value) => maxUsedUnit = max((value != null)? value.finaltotalTk : 0, maxUsedUnit));
    return maxUsedUnit;
  }
}