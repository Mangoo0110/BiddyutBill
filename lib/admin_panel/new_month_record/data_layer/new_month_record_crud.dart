import 'dart:convert';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class MonthRecordStorage{

  Future<bool>pushMonthlyRecord(
    {
      required String monthYear,
      required MonthlyRecord record,
    }
  ) async{
    bool pushed =false;
    try {
      print("pushing  + ${record.fullName.toString()} ${record.typeA} ${record.typeB} ${record.typeS}");
        final res = await http.post(
        Uri.parse(API.newMonthRecord),
        headers: {"Accept":"application/json"},
        body: {
          monthAndYear : monthYear.toString(),
          varsityId : record.varsityid.toString(),
          name : record.fullName.toString(),
          occupatioN : record.occupation.toString(),
          buildingname : record.buildingName.toString(),
          houseno : record.houseNo.toString(),
          meterno: record.meterNo,
          accountno : record.accountNo.toString(),
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
       print(res.body);
      if(res.statusCode == 500){
        return false;
      }
      else if(res.statusCode == 404){
        return false;
      }
      else{
        final  resBodyData = jsonDecode(res.body);
        if(resBodyData["Success"]==true)pushed = true;
        print(resBodyData);
        Fluttertoast.showToast(msg: resBodyData);
        return pushed;
      }
    } catch (e) {
      
      //Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
      return pushed;
    }
  }
Future <List<MonthlyRecord>> fetchRecord(
  {
    required String monthYear,
    required String varsityid,
  }
) async{
  try {
    final res = await http.post(
      Uri.parse(API.fetchMonthRecord),
      body: {
        monthAndYear: monthYear,
        varsityId : varsityid,
      }
    );
    if(res.statusCode == 200){      
      return monthlyRecordConvert(res.body);
    }
    else {
    return <MonthlyRecord>[];
    }
  } catch (e) {
    print(e.toString());
    return <MonthlyRecord>[];
  }
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
      return monthlyRecordConvert(res.body);
    }
    else {
    return <MonthlyRecord>[];
    }
  } catch (e) {
    print(e.toString());
    return <MonthlyRecord>[];
  }
}


  List<MonthlyRecord> monthlyRecordConvert(String jsonString) { 
    final data = jsonDecode(jsonString) ;
    return List<MonthlyRecord>.from(
        (data.map((item) => MonthlyRecord.fromJson(item))));
  }

}

