import 'dart:convert';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class DemandChargeVatPercentageStorage {
  List<DemandChargeVatPercentage> demandChargeVatPercentage(String jsonString) {
    
    final data = jsonDecode(jsonString);
    return List<DemandChargeVatPercentage>.from(
        (data.map((item) => DemandChargeVatPercentage.fromJson(item))));
  }

  Future<List<DemandChargeVatPercentage>> fetchDemandChargeVatPercentageStorage() async {
    var result = await http.post(
      Uri.parse(API.fetchDemandChargeVatPercentage),
    );
    if (result.statusCode == 200) {
      print(result.body);
      List<DemandChargeVatPercentage> list =demandChargeVatPercentage(result.body);
      return list;
    } else {
      return <DemandChargeVatPercentage>[];
    }
  }
}