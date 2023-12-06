import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';

class DemandChargeVatPercentage{
  double demandChargeTk;
  double vatPercentageTk;
  bool typeA;
  bool typeB;
  bool typeS;

  DemandChargeVatPercentage({
    required this.demandChargeTk,
    required this.vatPercentageTk,
    required this.typeA,
    required this.typeB,
    required this.typeS,
    });

  factory DemandChargeVatPercentage.fromJson(Map<String, dynamic> json){
     return DemandChargeVatPercentage(
        demandChargeTk: double.parse(json[demandCharge]) ,
        vatPercentageTk: double.parse(json[vatPercentage]) ,
        typeA: json[aType]=="0"?false:true ,
        typeB: json[bType]=="0"?false:true ,
        typeS: json[sType]=="0"?false:true ,
      );
  }
}
