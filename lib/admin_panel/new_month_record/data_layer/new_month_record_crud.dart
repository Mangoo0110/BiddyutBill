import 'dart:convert';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
class MonthRecordStorage{

  Future<String>pushMonthlyRecord(
    {
      required String monthYear,
      required MonthlyRecord record,
    }
  ) async{
    try {
      print("pushing " + record.fullName.toString());
        final res = await http.post(
        Uri.parse(API.newMonthRecord),
        headers: {"Accept":"application/json"},
        body: {
          monthAndYear : monthYear.toString(),
          varsityId : record.varsityid.toString(),
          name : record.fullName.toString(),
          houseAddresS : record.houseAddress.toString(),
          meterNo : record.meterno.toString(),
          presentMeterReading : record.presentmeteRreading.toString(),
          previousMeterReading : record.previousmeterReading.toString(),
          usedUnit : record.usedunit.toString(),
          unitCostTk : record.unitcostTk.toString(),
          demandChargeTk : record.demandchargeTk.toString(),
          firstTotalTk : record.firsttotalTk.toString(),
          vat : record.vatTk.toString(),
          secondTotalTk : record.secondtotalTk.toString(),
          finalTotalTk : record.finaltotalTk.toString(),
        }
      );
      print(res.body);
      if(res.statusCode == 500){
        return res.body;
      }
      else if(res.statusCode == 404){
        return res.body;
      }
      else{
        final  resBodyData = jsonDecode(res.body);
        Fluttertoast.showToast(msg: resBodyData);
        return resBodyData;
      }
    } catch (e) {
      
      //Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
      return e.toString();
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
    //print(res.body);
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

