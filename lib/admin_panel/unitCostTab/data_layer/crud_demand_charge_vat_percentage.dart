import 'dart:convert';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      List<DemandChargeVatPercentage> list = demandChargeVatPercentage(result.body);
      return list;
    } else {
      return <DemandChargeVatPercentage>[];
    }
  }

  Future<bool> updateVatAndDemand({
    required DemandChargeVatPercentage updatedVatAndDemandData
  }) async {
    try {
      var res = await http.post(Uri.parse(API.updateDemandChargeVatPercentage),
                  headers: {"Accept": "application/json"},
                  body: {
                    demandCharge : updatedVatAndDemandData.demandChargeTk.toString(),
                    vatPercentage : updatedVatAndDemandData.vatPercentageTk.toString(),
                    aType : updatedVatAndDemandData.typeA.toString(),
                    bType : updatedVatAndDemandData.typeB.toString(),
                    sType : updatedVatAndDemandData.typeS.toString()
                  }
                );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5, msg: "Updated Successfully");
          return true;
        } else {
          Fluttertoast.showToast(msg: "Update failed");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
              timeInSecForIosWeb: 5, msg: e.toString());
    }
    return false;
  }
}