
import 'dart:async';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/add_or_remove_house_user.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/assigned_user_list.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/constants/responsive_constants.dart';
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

  User? assignedUser;

  bool typeA = true;
  bool typeB = false;
  bool typeS  = false;

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
              timeInSecForIosWeb: 5,
              msg:
                  "Could not update House (Building Name : ${house.buildingName} and House No : ${house.houseNo}). [Building Name] and [House No] should be unique.");
      return false;
      }
      if(assignedUserID.isNotEmpty){
      assignedUser = await UserStorage().fetchOneUser(varsityId: assignedUserID);
      success = await UserStorage().assignUserAHouse(varsityId: assignedUserID, house: house);
      if(success){
        Fluttertoast.showToast(
              timeInSecForIosWeb: 5,
              msg:
                  "Success! House (Building Name : ${house.buildingName} and House No : ${house.houseNo}, User: ${assignedUser!.fullName}.");
          return true;
      }
      else{
        Fluttertoast.showToast(
              timeInSecForIosWeb: 5,
              msg:
                  "UserId ${house.assignedUserID} is not valid!!");
        return false;
      }
      }
        if(assignedUserID.isEmpty){
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5,
              msg:
                  "Success! House (Building Name : ${house.buildingName} and House No : ${house.houseNo} is updated without user.");
         return true;
        }
      return false;
  }

  House? makeAHouse(){
      buildingName = buildingNameInputController.text.trim();
      if(buildingName==''){
        Fluttertoast.showToast(msg: "BuildingName can not be empty!!",
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          );
        return null;
      }
      houseNo = houseNoInputController.text.trim();
      if(houseNo ==''){
        Fluttertoast.showToast(msg: "HouseNo can not be empty!!", timeInSecForIosWeb: 5);
        return null;
      }
      meterNo = meterNoInputController.text.trim();
      House house = House(buildingName: buildingName, houseNo: houseNo, meterNo: meterNo, assignedUserID: assignedUserID, typeA: typeA, typeB: typeB, typeS: typeS);      
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
    typeA = widget.thisHouse.typeA;
    typeB = widget.thisHouse.typeB;
    typeS = widget.thisHouse.typeS;
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
      child: LayoutBuilder(
        builder:(context,constraints)=> AlertDialog(
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
                  SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                             Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("House Type :",style: TextStyle(color: Colors.black,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: (typeA==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                color: (typeA==true)?Colors.green.shade200:Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: typeA,
                                     onChanged: (val){
                                      if(widget.thisHouse.assignedUserID == ""){
                                        setState(() {
                                          typeA = true;
                                          typeS = false;
                                          typeB = false;
                                        });
                                      }
                                     }
                                   ),
                                   Text("A",style: TextStyle(color: (typeA==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: (typeB==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                color: (typeB==true)?Colors.green.shade200:Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: typeB,
                                   onChanged: (val){
                                    if(widget.thisHouse.assignedUserID == ""){
                                      setState(() {
                                        typeB = true;
                                        typeA = false;
                                        typeS = false;
                                      });
                                    }
                                   }
                                   ),
                                    Text("B",style: TextStyle(color: (typeB==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: (typeS==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                color: (typeS==true)?Colors.green.shade200:Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                   Checkbox(
                                    value: typeS,
                                   onChanged: (val){
                                    if(widget.thisHouse.assignedUserID == ""){
                                      setState(() {
                                        typeS = true;
                                        typeA = false;
                                        typeB = false;
                                      });
                                    }
                                   }
                                   ),
                                    Text("S",style: TextStyle(color: (typeS==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                 
                                ],
                              ),
                            ),
                          ),
                        ),
                                        
                          ],
                        ),
                      ),
                    
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: TextFormField(
                      key: buildingNameFormKey,
                      controller: buildingNameInputController,
                      readOnly: true,
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
                        bool res = await UserStorage().deleteHouseOfUser(id: assignedUserID);
                        if(res){
                          res = await HouseStorage().deleteHouseAssignedUser(house: widget.thisHouse);
                          if(res){
                            setState(() {
                            assignedUserID ='';
                            widget.thisHouse.assignedUserID = '';
                            userAssigned =false;
                            // print("house updated");
                          });
                          }
                        }
                        // setState(() {
                        //     assignedUserID ='';
                        //     widget.thisHouse.assignedUserID = '';
                        //     userAssigned =false;
                        //     print("house updated");
                        //   });
                        },
                        assignedUserID: assignedUserID, ),
                      ],
                      ),
                    ),
                  ),
                  (!userAssigned)?AddOrRemoveHouseUser(
                    assignedUserId: assignedUserID,
                    typeA: typeA,
                    typeB: typeB,
                    typeS: typeS,
                    userSelected: (user) async{
                      setState(() {
                       widget.thisHouse.assignedUserID = user.id;
                       assignedUser = user;
                      });
                    },
                  ):const Text(""),
                ],
              ),
            ),
          ),),
      ),
    );
  }
  
}
