import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/houseModel.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddHouse extends StatefulWidget {
  const AddHouse({super.key});

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


  addHouse() async {
    try {
      buildingName = buildingNameInputController.text.trim();
      houseNo = houseNoInputController.text.trim();
      meterNo = meterNoInputController.text.trim();
      assignedUserID = assignedUserIDInputController.text.trim();
      var res = await http.post(Uri.parse(API.addHouse), body: {
        "buildingName": buildingName,
        "houseNo": houseNo,
        "meterNo": meterNo,
        "assignedUserID": assignedUserID,
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          Fluttertoast.showToast(
              msg:
                  "New House (Building Name : $buildingName and House No : $houseNo) added.");
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Could not add House (Building Name : $buildingName and House No : $houseNo). [Building Name] and [House No] should be unique.");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getExistingHouse() {
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is House) {
        House thisHouse = args;
        buildingNameInputController.text = thisHouse.buildingName;
        houseNoInputController.text = thisHouse.houseNo;
        meterNoInputController.text = thisHouse.meterNo;
        assignedUserIDInputController.text = thisHouse.assignedUserID;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getExistingHouse();
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: _createHouseBtn,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AlertDialog(
          backgroundColor: Colors.black,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(children: [
              Row(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.01,
                  ),
                  child: CloseButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.2,
                  ),
                  child: const Text(
                    "New house",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.01,
                  ),
                  child: IconButton(
                      onPressed: () {
                        // if(buildingNameFormKey.currentState!.validate() & houseNoFormKey.currentState!.validate()){
                        //   addHouse();
                        // }
                        var isValid = buildingNameFormKey.currentState!.validate()&&houseNoFormKey.currentState!.validate()&&meterNoFormKey.currentState!.validate()&&assignedUserIdFormKey.currentState!.validate();
                        if(isValid){
                        addHouse();
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                ),
              ]),
            ]),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.03, horizontal: size.width * 0.01),
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
                      validator: (val) {
                        RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                        if (val == "") {
                          return "This field can not be empty!";
                        } else if (rg.hasMatch(val!)) {
                          return "Enter character as (a-z),(0-9)..";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Name of the building",
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
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
                      validator: (val) {
                        RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                        if (val == "") {
                          return "This field can not be empty!";
                        } else if (rg.hasMatch(val!)) {
                          return "Enter character as (a-z),(0-9)..";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "House No",
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
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
                      validator: (val) {
                        RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                        if (val == "") {
                          return "This field can not be empty!";
                        } else if (rg.hasMatch(val!)) {
                          return "Enter character as (a-z),(0-9)..";
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Meter No",
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // Assign a user textField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    child: TextFormField(
                      key: assignedUserIdFormKey,
                      controller: assignedUserIDInputController,
                      validator: (val) {
                        RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                        if (rg.hasMatch(val!)) {
                          return "Enter character as (a-z),(0-9)..";
                        }
                        return "all good";
                      },
                      decoration: const InputDecoration(
                        labelText: "Assign a user",
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        hintText: "Type a userId...",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}
