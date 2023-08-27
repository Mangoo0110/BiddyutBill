import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_constants.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserStorage {
  List<User> usersFromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<User>.from((data.map((item) => User.fromJson(item))));
  }

  Future<List<User>> fetchAllUsers() async {
    var result = await http.post(
      Uri.parse(API.fetchAllUsers),
    );
    if (result.statusCode == 200) {
      //print(result.body);
      List<User> list = usersFromJson(result.body);
      return list;
    } else {
      return <User>[];
    }
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
    var result = await http.post(Uri.parse(API.fetchOneUser), body: {
      varsityid: varsityId,
    });
    if (result.statusCode == 200) {    
      var user = oneUserFromJson(result.body);
      return user;
    } else {
      return null;
    }
  }

  Future<bool> assignUserHouse(
    {
      required String varsityId,
      required House house,
    }
  )async {
    var user = await fetchOneUser(varsityId: varsityId);
    if(user!=null){
      user.buildingName = house.buildingName;
      user.houseNo = house.houseNo;
      user.meteNo = house.meterNo;
      return await addOrUpdateUser(user: user);
    }
    return false;
  }

  Future<bool> deleteHouseOfUser({
    required String varsityId
    })async {
    var user = await fetchOneUser(varsityId: varsityId);
    if(user!=null){
      user.buildingName = "";
      user.houseNo = "";
      user.meteNo = "";
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
        varsityid : user.varsityId,
         name : user.fullName,
         occupatioN : user.occupation,
         accountno : user.accountNo,
         email : user.emailAdress,
         isEmailverified : user.isEmailVerified,
         buildingname : user.buildingName,
         houseno : user.houseNo,
         meterno : user.meteNo
      });
      var data = jsonDecode(res.body);
       //Fluttertoast.showToast(msg:data.toString());
      if (res.statusCode == 200) {
        
        print(data.toString());
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
        varsityid : user.varsityId
      });
      if(res.statusCode ==200){
        print("user data:: ${res.body}");
        var data = jsonDecode(res.body);
        if(data["Success"]){
          if(user.buildingName.isEmpty && user.houseNo.isEmpty)return true;
          House house = House(buildingName: user.buildingName, houseNo: user.houseNo, meterNo: user.meteNo, assignedUserID: user.varsityId);
          var deleteHouseUser = await HouseStorage().deleteHouseAssignedUser(house: house);
          if(!deleteHouseUser){
            var regainUser = addOrUpdateUser(user: user);
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
