    import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';

MonthlyRecord calcOfFinalTotal({required MonthlyRecord record, required List<DemandChargeVatPercentage> demandChargeAndVatPercentage, required List<UnitCost> allUnitCost}){
    record.usedunit = record.presentmeteRreading - record.previousmeterReading;
    record.usedunit.toStringAsFixed(3);
    for(int index = 0; index<allUnitCost.length; index++){
      if(record.usedunit >= allUnitCost[index].startingRange && record.usedunit <= allUnitCost[index].endingRange){
        record.unitcostTk = record.usedunit * allUnitCost[index].rate;
        record.unitcostTk.toStringAsFixed(3);
        break;
      }
    }
    record.firsttotalTk =  record.unitcostTk + demandChargeAndVatPercentage[0].demandChargeTk;
    record.firsttotalTk.toStringAsFixed(3);
    record.secondtotalTk = record.firsttotalTk + record.firsttotalTk * (demandChargeAndVatPercentage[0].vatPercentageTk / 100);
    record.secondtotalTk.toStringAsFixed(3);
    record.finaltotalTk =  record.secondtotalTk.round().toDouble();
    return record;
   }

   