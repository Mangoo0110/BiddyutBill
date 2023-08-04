
import 'dart:convert';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CurrrentAdmin{
  static Future<void> setCurrentAdmin(Admin adminInfo)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String adminJsonData = jsonEncode(adminInfo.toJson());
    await preferences.setString("currentAdmin", adminJsonData);
  }
  static Future<Admin?> getCurrentAdmin()async{
    Admin? currentAdminInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String adminInfo =   preferences.getString("currentAdmin")!;
    if(adminInfo != null){
      Map<String,dynamic> adminDataMap = jsonDecode(adminInfo);
      currentAdminInfo = Admin.fromJson(adminDataMap);
    }
    return currentAdminInfo;
  }

}