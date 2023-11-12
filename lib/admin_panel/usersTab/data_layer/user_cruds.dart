import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_constants.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserStorage {
 Future<List<User>> usersFromJson(String jsonString) async{
    final data = jsonDecode(jsonString);
    return List<User>.from((data.map((item) {
      final user = User.fromJson(item);
      //final b = addOrUpdateUser(user: user);
      return user;
    })));
  }

  Future<List<User>> fetchAllUsers() async {
    try {
      var result = await http.post(Uri.parse(API.fetchAllUsers),);
      //print(result.body);
      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);
        if(data["Success"]==true){
        List<User> list = await usersFromJson(jsonEncode(data["Data"]));
        return list;
        }
      }
    }
    catch (e) {
      print(e.toString());
    }
    return <User>[];
  }

  User? oneUserFromJson(String jsonString){
    final datax = jsonDecode(jsonString);
    if(datax["Success"]==false) return null;
    final data = datax["Data"];
    //print(data);
    var res =
        User.fromJson(data);
    return res;
  }

 Future<User?>fetchOneUser(
  {
    required String varsityId,
  }) async {
    try {
      var result = await http.post(Uri.parse(API.fetchOneUser), body: {
      varsityid: varsityId,
    });
    if (result.statusCode == 200) {    
      var user = oneUserFromJson(result.body);
      return user;
    } else {
      return null;
    }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
    return null;
  }

  Future<bool> assignUserAHouse(
    {
      required String varsityId,
      required House house,
    }
  )async {
    var user = await fetchOneUser(varsityId: varsityId);
    if(user!=null){
      user.buildingName = house.buildingName;
      user.houseNo = house.houseNo;
      user.meterNo = house.meterNo;
      return await addOrUpdateUser(user: user);
    }
    return false;
  }

  Future<bool> deleteHouseOfUser({
    required String id
    })async {
    var user = await fetchOneUser(varsityId: id);
    if(user!=null){
      user.buildingName = "";
      user.houseNo = "";
      user.meterNo = "";
      return await addOrUpdateUser(user: user);
    }
    return false;
  }

  Future<bool>addOrUpdateUser(
    {
      required User user
    }
  ) async{
    try {
      var res = await http.post(Uri.parse(API.addOrUpdateUser), headers: {
        "Accept": "application/json"
      }, body: {
        varsityid : user.id,
         name : user.fullName,
         occupatioN : user.occupation,
         accountno : user.accountNo,
         email : user.emailAdress,
         isEmailverified : user.isEmailVerified.toString(),
         buildingname : user.buildingName,
         houseno : user.houseNo,
         meterno : user.meterNo,
         aType : user.typeA.toString(),
         bType : user.typeB.toString(),
         sType : user.typeS.toString(),
      });
      
      print(res.body);
      var data = jsonDecode(res.body);
       //Fluttertoast.showToast(msg:data.toString());
      if (res.statusCode == 200) {
        
       // print(data.toString());
       return data["Success"];
      }
    } catch (e) {
      print(e.toString());
       Fluttertoast.showToast(msg: e.toString());
    }
   
    return false;
  }

  Future<bool>deleteUser({
    required User user
  }) async{
    try {
      var res = await http.post(Uri.parse(API.deleteUser),headers: {
        "Accept": "application/json"
      },
      body: {
        varsityid : user.id
      });
      if(res.statusCode ==200){
        var data = jsonDecode(res.body);
        if(data["Success"]){
          if(user.buildingName.isEmpty && user.houseNo.isEmpty)return true;
          House house = House(buildingName: user.buildingName, houseNo: user.houseNo, meterNo: user.meterNo, assignedUserID: user.id, typeA: true, typeB: false, typeS: false);
          var deleteHouseUser = await HouseStorage().deleteHouseAssignedUser(house: house);
          if(!deleteHouseUser){
            var restoreUser = addOrUpdateUser(user: user);
            return false;
          }
          else{
            return true;
          }

        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }
}
