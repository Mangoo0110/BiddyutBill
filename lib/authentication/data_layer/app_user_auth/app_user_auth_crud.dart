import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/shared_pref/data_layer/shared_pref_appuser_setting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AppUserAuthStorage{

Future<User?>login({
    required String email,
    required String password,
  })async{
  try {

      //print("$email , $password");
      var res = await http.post(
          Uri.parse(API.appUserLogIn),
          headers: {"Accept":"application/json"},
          body: {
            "email": email,
            "pwd": password,
          }
      );
      print(res.statusCode);
      if(res.statusCode == 200){
        var resBodyOfLogin = jsonDecode(res.body);
        print(res.body);
        if(resBodyOfLogin["Success"]==true){
          //final message = resBodyOfLogin["Message"];
          //Fluttertoast.showToast(msg: message);
          final userData = resBodyOfLogin["User"];
          User user = User.fromJson(userData);
          AppPersistantStorage storage = AppPersistantStorage();
          await storage.init();
          final x = await storage.setCurrentAppUserPublic(publicInfo: user);
          print(x);
          if(x==true)return user;
          // CurrrentAdmin.setCurrentAdmin(adminInfo);
          // CurrrentAdmin().setLoggedIn(setter: true);
          return null;
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

  Future<void>logOut()async{
    AppPersistantStorage storage = AppPersistantStorage();
    await storage.init();
    storage.removeCurrentAppUserPublic();
  }

  Future<User?>verifyEmailAddress({
    required String email
  }) async{
    try {

      //print("$email , $password");
      var res = await http.post(
          Uri.parse(API.sendUserEmailVerificationOTP),
          headers: {"Accept":"application/json"},
          body: {
            "email": email,
          }
      );
      print(res.statusCode);
      if(res.statusCode == 200){
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin["Success"]==true){
          //final message = resBodyOfLogin["Message"];
          //Fluttertoast.showToast(msg: message);
          final userData = resBodyOfLogin["User"];
          User user = User.fromJson(userData);
          AppPersistantStorage storage = AppPersistantStorage();
          await storage.init();
          final x = storage.setCurrentAppUserPublic(publicInfo: user);
          print(x);
          if(x==true)return user;
          // CurrrentAdmin.setCurrentAdmin(adminInfo);
          // CurrrentAdmin().setLoggedIn(setter: true);
          return null;
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

  Future<bool>sendUserOTP({required String email })async{
    try{
       var res = await http.post(
          Uri.parse(API.sendUserOTP),
          headers: {"Accept":"application/json"},
          body: {
            "email": email,
          }
      );
      print("asking.. ${res.statusCode}");
      //var resBody = res.body;
      //print(resBody);
      if(res.statusCode == 200){
        var resBody= jsonDecode(res.body);
        print(resBody);
        if(resBody["Success"]==true){
          final datax = resBody["Message"];          
          print(datax);
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
    }
    return false;
  }

  Future<bool>validateUserOTP({required String email, required String otp})async{
    try{
      print(otp);
       var res = await http.post(
          Uri.parse(API.verifyUserOTP),
          headers: {"Accept":"application/json"},
          body: {
            "email": email,
            "otp": otp,
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

}