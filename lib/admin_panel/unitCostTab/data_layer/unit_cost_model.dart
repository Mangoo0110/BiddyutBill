import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:flutter/material.dart';

class UnitCost {
  final double startingRange;
  final double endingRange;
  final double rate;

  UnitCost({
    
    required this.startingRange,
    required this.endingRange,
    required this.rate,
  });

  factory UnitCost.fromJson(Map<String, dynamic> json) =>
      UnitCost(
        startingRange: double.parse(json[startRange]) ,
        endingRange: json[endRange]=="INF"?double.infinity :double.parse(json[endRange]) ,
        rate: double.parse(json[rateTk]) ,
      );

  Map<String, dynamic> toJson() => {
        startRange: startingRange,
        endRange: endingRange,
        rateTk: rate,
      };
}
