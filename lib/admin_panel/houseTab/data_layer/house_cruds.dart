
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
    //print(data);
    return List<House>.from(
        data.map((item) =>House.fromJson(item))
    );
  }

  Future<List<House>>fetchAllHouses()async{
      var result = await http.post(
        Uri.parse(API.fetchAllHouses),
      );
      if(result.statusCode == 200){
        //print(result.body);
        List<House> list = housesFromJson(result.body);
        return list;
      }
      else {
        return <House>[];
      }

}

Future<bool> addOrUpdateHouse(
  {
    required House house
  }
) async{
  try {
      var user = await UserStorage().fetchOneUser(varsityId: house.assignedUserID);
      if( (user!=null) && ((user.buildingName == "" && user.houseNo == "" && user.meteNo == "") ||
      (user.buildingName == house.buildingName && user.houseNo == house.houseNo && user.meteNo == house.meterNo))||house.assignedUserID == ''){
      var res = await http.post(Uri.parse(API.addOrUpdateHouse),
      headers: {"Accept":"application/json"},
       body: {
        buildingname: house.buildingName,
        houseno: house.houseNo,
        meterno: house.meterNo,
        assignedUserid: house.assignedUserID,
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data.toString());
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
    print(e.toString());
       Fluttertoast.showToast(
              msg: e.toString() );
      return false;
    }
    print("Could not add House (Building Name : ${house.buildingName} and House No : ${house.houseNo}, meter no : ${house.meterNo}, Assigned user: ${house.assignedUserID}). [Building Name] and [House No] should be unique.");
   
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
          var userDelete = await UserStorage().deleteHouseOfUser(varsityId: house.assignedUserID);
          if(!userDelete){
            var regainHouseUser = addOrUpdateHouse(house: house);
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