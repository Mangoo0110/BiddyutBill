
import 'dart:convert';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPersistantStorage{
  static String adminKey = "Admin";
  static String adminAuthKey = "Admin-Auth";
  static String publicKey = "Public";
  static String publicAuthKey = "Public-Auth";
  static String emptyKey = "No-AppUser";
  static String currentAppUser = "Current-AppUser";
  static late SharedPreferences persistentStorage;

   Future<void> init() async {
    persistentStorage = await SharedPreferences.getInstance();
  }

   Future<void> setCurrentAppUserAdmin({
    required Admin adminInfo,
   })async{
    persistentStorage.setString(currentAppUser, adminKey);
    String adminJsonData = jsonEncode(adminInfo.toJson());
    persistentStorage.setString(adminKey,adminJsonData);
    
  }
  Future<bool> setCurrentAppUserPublic({
    required User publicInfo
  })async{
    persistentStorage.setString(currentAppUser, publicKey);
    String publicJsonData = jsonEncode(publicInfo.toJson());
    persistentStorage.setString(publicKey, publicJsonData);
    final data = getCurrentAppUserPublic();
    if(data!=null)return true;
    return false;
  }
  void removeCurrentAppUserPublic()async{
    await persistentStorage.remove(publicKey);
    await persistentStorage.remove(currentAppUser);
  }
  Future<void> removeCurrentAppUserAdmin()async{
    await persistentStorage.remove(adminKey);
    await persistentStorage.remove(currentAppUser);
  }
  User? getCurrentAppUserPublic(){
    final data = persistentStorage.getString(publicKey);
    if(data!=null){
      final user = jsonDecode(data);
      return User.fromJson(user);
    }
    return null;

  }

  Future<Admin?>getCurrentAppUserAdmin()async{
    final data = await persistentStorage.getString(adminKey);
    if(data!=null){
      final user = jsonDecode(data);
      return Admin.fromJson(user);
    }
    return null;

  }
  Future<String>CurrentAppUserWho()async{
    final data = await persistentStorage.getString(currentAppUser);
    if(data!=null){
        return data;
    }
    return "None";

  }

}