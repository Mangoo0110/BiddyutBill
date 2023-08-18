import 'dart:convert';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class UnitCostStorage {
  List<UnitCost> unitCostFromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    //print(data);
    return List<UnitCost>.from(
        (data.map((item) => UnitCost.fromJson(item))));
  }

  Future<List<UnitCost>> fetchAllUnitCost() async {
    var result = await http.post(
      Uri.parse(API.fetchAllUnitCostAndOther),
    );
    if (result.statusCode == 200) {
      List<UnitCost> list = unitCostFromJson(result.body);
      return list;
    } else {
      return <UnitCost>[];
    }
  }
}
