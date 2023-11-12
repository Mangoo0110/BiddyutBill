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
  bool typeA = true;
  bool typeB = false;
  bool typeS  = false;
  User? assignedUser;

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
      success = await UserStorage().assignUserAHouse(varsityId: assignedUserID, house: house);
      if(success){
        Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo}) with User ${assignedUser!.fullName} added.");
          widget.onOk();
          return;
      }
      else{
        Fluttertoast.showToast(
              msg:
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo}) without user added.");
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
                  "Success! New House (Building Name : ${house.buildingName} and House No : ${house.houseNo}) without user added.");
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
      House house = House(buildingName: buildingName, houseNo: houseNo, meterNo: meterNo, assignedUserID: assignedUserID, typeA: typeA, typeB: typeB, typeS: typeS);
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
      child: LayoutBuilder(
        builder:(context,constraints)=> AlertDialog(
          scrollable: true,
          // alignment: Alignment.topRight,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            addHouse();
                          },
                          icon: const Icon(Icons.check,color: Colors.black,)),
                  ),
                ]),
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
                                    setState(() {
                                      typeA = true;
                                      typeS = false;
                                      typeB = false;
                                    });
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
                                  
                                  setState(() {
                                    typeB = true;
                                    typeA = false;
                                    typeS = false;
                                  });
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
                                  
                                  setState(() {
                                    typeS = true;
                                    typeA = false;
                                    typeB = false;
                                  });
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
                  
                  //Category textField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: TextFormField(
                      key: buildingNameFormKey,
                      controller: buildingNameInputController,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Assigned User :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AssignedUserList(
                          onRemove: () async{
                             bool res = await UserStorage().deleteHouseOfUser(id: assignedUserID);
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
                  AddOrRemoveHouseUser(
                    assignedUserId: assignedUserID,
                    typeA: typeA,
                    typeB: typeB,
                    typeS: typeS,
                    userSelected: (user) {
                      setState(() {
                        assignedUser = user;
                      });
                    },
                  )
                ],
              ),
            ),
          ),),
      ),
    );
       
  }
}

                