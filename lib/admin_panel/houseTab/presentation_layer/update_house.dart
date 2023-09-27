
import 'dart:async';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/add_user_to_house.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/assigned_user_list.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
typedef houseCallBack = void Function ();
class UpdateHouse extends StatefulWidget {
  House thisHouse ;
  houseCallBack onOk;
  UpdateHouse({Key? key, required this.thisHouse, required this.onOk}) : super(key: key);

  @override
  State<UpdateHouse> createState() => _UpdateHouseState();
}

class _UpdateHouseState extends State<UpdateHouse> {
  final String _updateHouseBtn = "update-a-house";

  String buildingName =  "";

  String houseNo =  "";

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


  late List<User> allUsers = [];
  bool userAssigned = false;

  Future<bool> updateHouse(BuildContext context)async{
      var house = makeAHouse();
      if(house==null)return false;
      print("updating house");
      var success = await HouseStorage().addOrUpdateHouse(house: house);
      if(!success){
        Fluttertoast.showToast(
              msg:
                  "Could not add House (Building Name : ${house.buildingName} and House No : ${house.houseNo}). [Building Name] and [House No] should be unique.");
      return false;
      }
      if(assignedUserID.isNotEmpty){
      success = await UserStorage().assignUserHouse(varsityId: assignedUserID, house: house);
      if(success){
        Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo} with UserID ${house.assignedUserID} added.");
        // Future.delayed(const Duration(seconds: 1), () {
        //     Navigator.pop(context);
        //   });
          return true;
      }
      else{
        Fluttertoast.showToast(
              msg:
                  "UserId ${house.assignedUserID} is not valid!!");
        return false;
      }
      }
        if(assignedUserID.isEmpty){
          Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo} without user added.");
         return true;
        }
      return false;
  }

  House? makeAHouse(){
      buildingName = buildingNameInputController.text.trim();
      if(buildingName==''){
        Fluttertoast.showToast(msg: "BuildingName can not be empty!!",
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
      return house;
  }

  getExistingHouse(){
   
        buildingNameInputController.text = widget.thisHouse.buildingName;
        houseNoInputController.text = widget.thisHouse.houseNo;
        meterNoInputController.text = widget.thisHouse.meterNo;
        assignedUserID = widget.thisHouse.assignedUserID;
        if(widget.thisHouse.assignedUserID != '')userAssigned =true;
        // assignedUserIDInputController.text = widget.thisHouse.assignedUserID;
  }
  @override
  void initState() {
    getExistingHouse();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getExistingHouse();
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: _updateHouseBtn,
      child: AlertDialog(
        // alignment: Alignment.topRight,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
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
                child: const Text("Update house",style: TextStyle(color: Colors.black),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: IconButton(
                      onPressed: ()async{
                       // if(buildingNameFormKey.currentState!.validate() & houseNoFormKey.currentState!.validate()){
                       //   addHouse();
                       // }
                        var success = await updateHouse(context);
                        if(success){
                          widget.onOk();
                        }
                      },
                      icon: const Icon(Icons.check,color: Colors.black,)),
              ),
            ]),
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
                    readOnly: true,
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
                    readOnly: true,
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
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text("Assigned User :",style: TextStyle(color: Colors.black),)
                        ),
                      AssignedUserList(
                      onRemove: () async{
                      bool res = await UserStorage().deleteHouseOfUser(varsityId: assignedUserID);
                      res = await HouseStorage().deleteHouseAssignedUser(house: widget.thisHouse);
                      setState(() {
                          assignedUserID ='';
                          widget.thisHouse.assignedUserID = '';
                          userAssigned =false;
                          print("house updated");
                        });
                      },
                      assignedUserID: assignedUserID, ),
                    ],
                    ),
                  ),
                ),
                (!userAssigned)?AddUserToHouse(
                  assignedUserId: assignedUserID,
                  userSelected: (userId) async{
                    setState(() {
                     widget.thisHouse.assignedUserID = userId;
                     assignedUserID = userId;
                    });
                  },
                ):const Text(""),
              ],
            ),
          ),
        ),),
    );
       
       }
   
}
