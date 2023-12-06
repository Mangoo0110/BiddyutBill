import 'dart:convert';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UnitCostStorage {
  List<UnitCost> unitCostFromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<UnitCost>.from(
        (data.map((item) => UnitCost.fromJson(item))));
  }

  Future<List<UnitCost>> fetchAllUnitCost() async {
    var result = await http.post(
      Uri.parse(API.fetchAllUnitCost),
    );
    if (result.statusCode == 200) {
      List<UnitCost> list = unitCostFromJson(result.body);
      return list;
    } else {
      return <UnitCost>[];
    }
  }
  Future<bool> addNewUnitCostRange({
    required UnitCost newUnitCost
  }) async{
    try{
      var result = await http.post(
        Uri.parse(API.addNewUnitRangeWithCost),
        body: {
          startRange : newUnitCost.startingRange.toString(),
          endRange : newUnitCost.endingRange.toString(),
          rateTk : newUnitCost.rate.toString(),
        }
      );
      if(result.statusCode == 200){
        var data = jsonDecode(result.body);
        if(data["Success"]==true){
          return true;
        }
        else{
          var message = data["Message"];
          Fluttertoast.showToast(msg: message);
        }
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }
  Future<bool> deleteUnitRangeCost({
    required UnitCost unitRangeCost
  }) async{
    try{
      var result = await http.post(
        Uri.parse(API.deleteUnitRangeWithCost),
        body: {
          startRange : unitRangeCost.startingRange.toString(),
          endRange : unitRangeCost.endingRange.toString(),
          rateTk : unitRangeCost.rate.toString(),
        });
        if(result.statusCode == 200){
          var data = jsonDecode(result.body);
          if(data["Success"]==true){
            return true;
          }
          else{
            var message = data["Message"];
            Fluttertoast.showToast(msg: message);
          }
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }
}
