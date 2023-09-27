    import 'dart:math';

import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/double_set_precision.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';

MonthlyRecord calcOfFinalTotal({required MonthlyRecord record ,required List<UnitCost> allUnitCost}){
  print(record.fullName);
    record.usedunit = max(0,  (record.presentmeteRreading - record.previousmeterReading));
    record.usedunit = doubleSetPrecision(num: record.usedunit, setPrecision: 2);
    //for type B....
    if(record.typeB == true){
      record.unitcostTk = record.usedunit * 11.93;
      record.unitcostTk = doubleSetPrecision(num: record.unitcostTk, setPrecision: 2);
      record.firsttotalTk =  record.unitcostTk + 75;
      print("demand charge ${record.firsttotalTk}");
    }
    //for type A and S....
    else{
    for(int index = 0; index<allUnitCost.length-1; index++){
      if(record.usedunit >= allUnitCost[index].startingRange && record.usedunit <= allUnitCost[index].endingRange){
        record.unitcostTk = record.usedunit * allUnitCost[index].rate;
        record.unitcostTk = doubleSetPrecision(num: record.unitcostTk, setPrecision: 2);
        break;
      }
    }
    if(record.usedunit>=allUnitCost[allUnitCost.length-1].startingRange){
      record.unitcostTk = record.usedunit * allUnitCost[allUnitCost.length-1].rate;
      record.unitcostTk = doubleSetPrecision(num: record.unitcostTk, setPrecision: 2);
    }
    
    record.firsttotalTk =  record.unitcostTk + record.demandchargeTk;
    print("demand charge ${record.firsttotalTk}");
    }
    record.firsttotalTk = doubleSetPrecision(num: record.firsttotalTk, setPrecision: 2);
    record.secondtotalTk = record.firsttotalTk + record.firsttotalTk * (record.vatTk / 100);
    record.secondtotalTk = doubleSetPrecision(num: record.secondtotalTk, setPrecision: 2);
    record.finaltotalTk =  record.secondtotalTk.round().toDouble();
    return record;
   }

   