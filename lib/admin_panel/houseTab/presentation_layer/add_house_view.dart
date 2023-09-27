import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/add_user_to_house.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/assigned_user_list.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
typedef houseCallBack = void Function ();
class AddHouse extends StatefulWidget {
  houseCallBack onOk;
   AddHouse({super.key, required this.onOk});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  final String _createHouseBtn = "create-a-house";
  String buildingName = "";
  String houseNo = "";
  String meterNo = "";
  String assignedUserID = "";

  var buildingNameFormKey = GlobalKey<FormState>();

  var meterNoFormKey = GlobalKey<FormState>();

  var houseNoFormKey = GlobalKey<FormState>();

  var assignedUserIdFormKey = GlobalKey<FormState>();


  TextEditingController buildingNameInputController = TextEditingController();
  TextEditingController meterNoInputController = TextEditingController();
  TextEditingController houseNoInputController = TextEditingController();
  TextEditingController assignedUserIDInputController = TextEditingController();
  StreamController assignedUserStreamController = StreamController();

  addHouse() async {
      var house = await makeAHouse();
      if(house==null)return;
      var success = await HouseStorage().addOrUpdateHouse(house: house);
      if(!success){
        Fluttertoast.showToast(
              msg:
                  "Could not add House (Building Name : ${house.buildingName} and House No : ${house.houseNo}). [Building Name] and [House No] should be unique.");
      return;
      }
      if(assignedUserID.isNotEmpty){
      success = await UserStorage().assignUserHouse(varsityId: assignedUserID, house: house);
      if(success){
        Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo} with UserID ${house.assignedUserID} added.");
          widget.onOk();
          return;
      }
      else{
        Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo} without user added.");
        Fluttertoast.showToast(
            textColor: Colors.orange,
              msg:
                  "UserId ${house.assignedUserID} is not valid!!");
         widget.onOk();
      }
      }
        if(assignedUserID.isEmpty){
          Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo} without user added.");
         widget.onOk();
        }
      
  }
  Future<House?> makeAHouse()async{
      buildingName = buildingNameInputController.text.trim();
      if(buildingName==''){
        Fluttertoast.showToast(msg: "BuildingName can not be empty!!",
          //webBgColor: "linear-gradient(to right, #00000, #00000)",
          toastLength: Toast.LENGTH_LONG,
          );
        return null;
      }
      houseNo = houseNoInputController.text.trim();
      if(houseNo ==''){
        Fluttertoast.showToast(msg: "HouseNo can not be empty!!");
        return null;
      }
      meterNo = meterNoInputController.text.trim();
      House house = House(buildingName: buildingName, houseNo: houseNo, meterNo: meterNo, assignedUserID: assignedUserID);
      var check = await HouseStorage().fetchHouse(house: house);
      if(check.isNotEmpty){
        Fluttertoast.showToast(
              msg:
                  "This house already exists. [Building Name] and [House No] should be unique.");
      return null;
      }
      return house;
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: _createHouseBtn,
      child: AlertDialog(
        scrollable: true,
        // alignment: Alignment.topRight,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.02,
                    ),
                    child: CloseButton(
                      color: Colors.black,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                    ),
                    child: const Text("New house",style: TextStyle(color: Colors.black),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.02,
                    ),
                    child: IconButton(
                          onPressed: (){
                           // if(buildingNameFormKey.currentState!.validate() & houseNoFormKey.currentState!.validate()){
                           //   addHouse();
                           // }
                            addHouse();
                          },
                          icon: const Icon(Icons.check,color: Colors.black,)),
                  ),
                ]),
              ),
            ),
          ]
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(
              vertical: size.height * 0.03,
              horizontal: size.width * 0.01
            ),
            child: Column(
              children: [
                //Category textField
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: TextFormField(
                    key: buildingNameFormKey,
                    controller: buildingNameInputController,
                    validator: (val){
                      RegExp rg = RegExp(r"^[a-z0-9]",caseSensitive: false);
                      if(val==""){
                        return "This field can not be empty!";
                      }
                      else if(rg.hasMatch(val!)){
                        return "Enter character as (a-z),(0-9)..";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Name of the building",
                      labelStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                //House no textField
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  child: TextFormField(
                    key: houseNoFormKey,
                    controller: houseNoInputController,
                    validator: (val){
                      RegExp rg = RegExp(r"^[a-z0-9]",caseSensitive: false);
                      if(val==""){
                        return "This field can not be empty!";
                        }
                      else if(rg.hasMatch(val!)){
                        return "Enter character as (a-z),(0-9)..";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "House No",
                      labelStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                //Meter no textField
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  child: TextFormField(
                    key: meterNoFormKey,
                    controller: meterNoInputController,
                    validator: (val){
                      RegExp rg = RegExp(r"^[a-z0-9]",caseSensitive: false);
                      if(val==""){
                        return "This field can not be empty!";
                      }
                      else if(rg.hasMatch(val!)){
                        return "Enter character as (a-z),(0-9)..";
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: "Meter No",
                      labelStyle: TextStyle(color: Colors.black),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                // Assign a user textField
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Assigned User :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AssignedUserList(
                        onRemove: () async{
                           bool res = await UserStorage().deleteHouseOfUser(varsityId: assignedUserID);
                            Future.delayed(const Duration(seconds: 1),(){
                            setState(() {
                             assignedUserID = "";
                          });
                            });                         
                        },
                        assignedUserID: assignedUserID),
                      ),
                    ],
                    ),
                  ),
                ),
                AddUserToHouse(
                  assignedUserId: assignedUserID,
                  userSelected: (userId) {
                    setState(() {
                      assignedUserID = userId;
                    });
                  },
                )
              ],
            ),
          ),
        ),),
    );
       
  }


}

                