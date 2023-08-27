import 'dart:convert';

import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
Future<bool> monthly_bill_email({ required MonthlyRecord record, required String monthAndYear})async{
  var name = record.fullName;
  var occupation = record.occupation;
  var meterNo = record.meterNo;
  var previousMeterReading = record.previousmeterReading;
  var presentMeterReading = record.presentmeteRreading;
  var usedUnit = record.usedunit;
  var unitcostTk = record.unitcostTk;
  var demandChargeTk = record.demandchargeTk;
  var firstTotalTk = record.firsttotalTk;
  var vatPercentage = record.vatTk;
  var secondTotalTk = record.secondtotalTk;
  var finalTotalTk = record.finaltotalTk;

   var userDetails = await UserStorage().fetchOneUser(varsityId: record.varsityid);
   if(userDetails!=null){
  var userEmail = userDetails.emailAdress;
  var serviceId = "service_biqwnhe";
  var templateId = "template_2b5rtuc";
  var userId = "bPhZhhuhyVlvOAFBy";
  var accessToken = "imABnvJAMBGAdhlVDcy-z";
  Future.delayed(const Duration(seconds: 1),() async{
    var res = await http.post(
    Uri.parse(API.onlineEmailjsApi),
    headers: {"Content-Type":"application/json"},
    body: json.encode({
      "service_id" : serviceId,
      "template_id" : templateId,
      "user_id" : userId,
      "accessToken" : accessToken,
      "template_params" :{
      "recipient_email" : userEmail,
      "month_year" : monthAndYear,
      "full_name" : name,
      "occupation" : occupation,
      "meter_no" : meterNo,
      "previous_meter_reading" : previousMeterReading,
      "present_meter_reading" : presentMeterReading,
      "used_unit" : usedUnit,
      "unit_cost_tk" : unitcostTk,
      "demand_charge_tk" : demandChargeTk,
      "first_total_tk" : firstTotalTk,
      "vat_percentage" : vatPercentage,
      "second_total_tk" : secondTotalTk,
      "final_total_tk" : finalTotalTk
      }
    })
  );
  print(res.body);
  }); 
  return true;
   }
   Fluttertoast.showToast(msg: "User not found!!");
   return false;
}

