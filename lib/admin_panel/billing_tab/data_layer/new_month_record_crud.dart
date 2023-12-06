import 'dart:convert';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class MonthlyRecordStorage{

Future<bool>pushMonthlyRecord(
    {
      required String monthYear,
      required MonthlyRecord record,
    }
  ) async{
    bool pushed =false;
    try {
        final res = await http.post(
        Uri.parse(API.newMonthRecord),
        headers: {"Accept":"application/json"},
        body: {
          monthAndYear : monthYear.toString(),
          varsityId : record.assignedUserID,
          name : record.fullName,
          occupatioN : record.occupation,
          accountno : record.accountNo,
          buildingname : record.buildingName.toString(),
          houseno : record.houseNo.toString(),
          meterno: record.meterNo,
          presentMeterReading : record.presentmeteRreading.toString(),
          previousMeterReading : record.previousmeterReading.toString(),
          usedUnit : record.usedunit.toString(),
          unitCostTk : record.unitcostTk.toString(),
          demandChargeTk : record.demandchargeTk.toString(),
          firstTotalTk : record.firsttotalTk.toString(),
          vat : record.vatTk.toString(),
          secondTotalTk : record.secondtotalTk.toString(),
          finalTotalTk : record.finaltotalTk.toString(),
          aType : record.typeA.toString(),
          bType : record.typeB.toString(),
          sType : record.typeS.toString(),
        }
      );
       //final  resBodyData = jsonDecode(res.body);
      if(res.statusCode == 500){
        return false;
      }
      else if(res.statusCode == 404){
        return false;
      }
      else{
        final  resBodyData = jsonDecode(res.body);
        if(resBodyData["Success"]==true)pushed = true;
        // print(resBodyData);
        Fluttertoast.showToast(msg: resBodyData);
        return pushed;
      }
    } catch (e) {
      
      //Fluttertoast.showToast(msg: e.toString());
      //print(e.toString());
      return pushed;
    }
  }

Future <MonthlyRecord?> fetchARecordForHouse(
  {
    required String monthYear,
    required House house,
  }
) async{
  try {
    final res = await http.post(
      Uri.parse(API.fetchMonthRecord),
      body: {
        monthAndYear : monthYear,
        buildingname : house.buildingName,
        houseno : house.houseNo
      }
    );
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      if(data["Success"]==true){
        return MonthlyRecord.fromJson(data["Data"]);
      }  
    }
  } catch (e) {
  }
  return null;
}

Future <MonthlyRecord?> fetchARecordForUser(
  {
    required String monthYear,
    required User user,
  }
) async{
  try {
    final res = await http.post(
      Uri.parse(API.fetcUserMonthlyRecord),
      body: {
        monthAndYear : monthYear,
        varsityId: user.id,
      }
    );
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      //print(res.body);
      if(data["Success"]==true){
        return MonthlyRecord.fromJson(data["Data"]);
      }  
    }
  } catch (e) {
    //print(e.toString());
  }
  return null;
}

Future <List<MonthlyRecord>> fetchAllRecord(
  {
    required String monthYear,
  }
) async{
  try {
    final res = await http.post(
      Uri.parse(API.fetchMonthAllRecord),
      body: {
        monthAndYear: monthYear,
      }
    );
    if(res.statusCode == 200){      
      return monthlyRecordListConvert(res.body);
    }
    else {
    return <MonthlyRecord>[];
    }
  } catch (e) {
    //print(e.toString());
    return <MonthlyRecord>[];
  }
}

List<MonthlyRecord> monthlyRecordListConvert(String jsonString) {
    final data = jsonDecode(jsonString) ;
    return List<MonthlyRecord>.from(
        (data.map((item) => MonthlyRecord.fromJson(item))));
  }

}

