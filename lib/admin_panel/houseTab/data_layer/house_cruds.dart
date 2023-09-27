
import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_constants.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HouseStorage{

  List<House>housesFromJson(String jsonString){
    final data = json.decode(jsonString);
    return List<House>.from(
        data.map((item) =>House.fromJson(item))
    );
  }

  Future<List<House>>fetchAllHouses()async{
  try {
    var result = await http.post(
        Uri.parse(API.fetchAllHouses),
      );
      if(result.statusCode == 200){
        List<House> list = housesFromJson(result.body);
        return list;
      }
      else {
        return <House>[];
      }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
      return <House>[];
}

Future<List<House>>fetchHouse({required House house})async{
  try {
    var result = await http.post(
        Uri.parse(API.fetchHouse),
        body: {
          buildingname : house.buildingName,
          houseno : house.houseNo,
        }
      );
      if(result.statusCode == 200){
        List<House> list = housesFromJson(result.body);
        return list;
      }
      else {
        return <House>[];
      }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    print(e.toString());
  }
      return <House>[];
}

Future<bool> addOrUpdateHouse(
  {
    required House house
  }
) async{
  try {
      var user = await UserStorage().fetchOneUser(varsityId: house.assignedUserID);
      if((user == null) || (user.varsityId == house.assignedUserID) || ((user.buildingName == "" && user.houseNo == "" && user.meteNo == "") || (user.buildingName == "null" && user.houseNo == "null" && user.meteNo == "null"))
      ||house.assignedUserID == ''){
      var res = await http.post(Uri.parse(API.addOrUpdateHouse),
      headers: {"Accept":"application/json"},
       body: {
        buildingname: house.buildingName,
        houseno: house.houseNo,
        meterno: house.meterNo,
        assignedUserid: house.assignedUserID,
      });
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
         return true;
        } else {
          return false;
        }
      }
    }
    else{
      Fluttertoast.showToast(msg: "Not a valid user!!");
    }
  }
  catch (e) {
      //  Fluttertoast.showToast(
      //         msg: e.toString() );
      return false;
    }
   
    return false;
  }

  Future<bool>deleteHouse({
    required House house
  })async{
    try {
      var res = await http.post(Uri.parse(API.deleteHouse),
      headers: {"Accept":"application/json"},
       body: {
        buildingname: house.buildingName,
        houseno: house.houseNo,
        meterno: house.meterNo,
        assignedUserid: house.assignedUserID,
      });
      if(res.statusCode==200){
        var data = jsonDecode(res.body);
        if(data["Success"]==true){
          if(house.assignedUserID!=''){
          var userDelete = await UserStorage().deleteHouseOfUser(varsityId: house.assignedUserID);
          if(!userDelete){
            var regainHouseUser = addOrUpdateHouse(house: house);
            return false;
          }
          else{
            return true;
          }
          }
          else {
            return true;
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }

  Future<bool>deleteHouseAssignedUser({
    required House house
  })async{
    try {
      var res = await http.post(Uri.parse(API.addOrUpdateHouse),
      headers: {"Accept":"application/json"},
       body: {
        buildingname: house.buildingName,
        houseno: house.houseNo,
        meterno: house.meterNo,
        assignedUserid: "",
      });
      if(res.statusCode==200){
        var data = jsonDecode(res.body);
        return data["Success"];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return false;
  }
  // Future<bool>houseAlreadyExist({
  //   required String buildingName,
  //   required String houseNo
  // }) async{
  //   try {
      
  //   } catch (e) {
      
  //   }
  // }
}