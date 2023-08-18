import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';

class DemandChargeVatPercentage{
  late final double demandChargeTk;
  late final double vatPercentageTk;


  DemandChargeVatPercentage({required this.demandChargeTk, required this.vatPercentageTk});

  factory DemandChargeVatPercentage.fromJson(Map<String, dynamic> json){
     return DemandChargeVatPercentage(
        demandChargeTk: double.parse(json[demandCharge]) ,
        vatPercentageTk: double.parse(json[vatPercentage]) ,
      );
  }
}
