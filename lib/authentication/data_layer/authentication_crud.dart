import 'dart:convert';
import 'dart:js_interop';

import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/authentication/data_layer/recovery_code_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AuthenticationStorage{
  Future<RecoverCodeModel?>askApiForRecoveryCode({required String varsityId })async{
    try{
       var res = await http.post(
          Uri.parse(API.adminAskRecoveryCode),
          headers: {"Accept":"application/json"},
          body: {
            "varsity_id": varsityId,
          }
      );
      print("asking.. ${res.statusCode}");
      //var resBody = res.body;
      //print(resBody);
      if(res.statusCode == 200){
        var resBody= jsonDecode(res.body);
        print(resBody);
        if(resBody["Success"]==true){
          final datax = resBody["Recovery_data"];
          var data = RecoverCodeModel.fromJson(datax);
          
          print(data);
          return data;
        }
        else{
          Fluttertoast.showToast(msg: resBody["Message"]);
          return null;
        }
      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "$e");
    }
    return null;
  }

  Future<bool>validateRecoveryCode({required String varsityId, required String recoveryCode})async{
    try{
      print(recoveryCode);
       var res = await http.post(
          Uri.parse(API.adminValidateRecoveryCode),
          headers: {"Accept":"application/json"},
          body: {
            "varsity_id": varsityId,
            "recovery_code": recoveryCode,
          }
      );
      print("validating.. ${res.statusCode}");
      print(res.body);
      if(res.statusCode == 200){
        var resBody= jsonDecode(res.body);
        if(resBody["Success"]==true){
          final data = resBody["Message"];
          print("validation data $data");
          return true;
        }
        else{
          Fluttertoast.showToast(msg: resBody["Message"]);
          return false;
        }
      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "$e");
      return false;
    }
    return false;
  }
Future<bool>sendAdminRecoveryEmail({required RecoverCodeModel recoverAdmin})async{
  var userEmail = recoverAdmin.emailAddress;
  var serviceId = "service_eeogflv";
  var templateId = "template_fhbo75j";
  var userId = "CQTo8CNKgxU4DEK5D";
  var accessToken = "bKHwkoQ1KYOV2KUII4bqi";
   print("email sent to  at $userEmail");
   try {
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
      "recovery_code" : recoverAdmin.recoveryCode,
      }
    }),
  );
  if(res.statusCode==200)return true;
   } catch (e) {
     print(e.toString());
   }
  return false;

}
}
