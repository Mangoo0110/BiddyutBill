import 'dart:convert';
import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/authentication/data_layer/admin_auth/admin_auth_model.dart';
import 'package:e_bill/shared_pref/data_layer/shared_pref_appuser_setting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AdminAuthStorage{

Admin adminFromJson(String jsonData){
    final decryptedJson = jsonDecode(jsonData);
    return Admin.fromJson(decryptedJson);
  }

Future<Admin?>adminLogin({
    required String email,
    required String password,
  })async{
  try {

      print("$email , $password");
      var res = await http.post(
          Uri.parse(API.adminLogIn),
          headers: {"Accept":"application/json"},
          body: {
            "email": email,
            "pwd": password,
          }
      );
      print(res.statusCode);
      if (res.statusCode == 200){
        print("success");
        var resBodyOfLogin = jsonDecode(res.body);

        if (resBodyOfLogin["Success"]==true){
          print(resBodyOfLogin["Success"]);
          Fluttertoast.showToast(msg: "Congrats, You are Logged In successfully");
          final adminData = jsonEncode(resBodyOfLogin["Admin"]);
          final admin = adminFromJson(adminData);
          print(adminData);
          AppPersistantStorage storage = AppPersistantStorage();
          await storage.init();
          storage.setCurrentAppUserAdmin(adminInfo: admin);
          return admin; 
        }
        else{
          Fluttertoast.showToast(msg: "Wrong Credentials!!");
        }
      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "$e");
    }
  return null;
  }

}