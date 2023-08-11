
import 'dart:convert';

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
  var buildingNameFormKey = GlobalKey<FormState>();
  var meterNoFormKey = GlobalKey<FormState>();
  var houseNoFormKey = GlobalKey<FormState>();
  var assignedUserIdFormKey = GlobalKey<FormState>();
  TextEditingController buildingNameInputController = TextEditingController();
  TextEditingController meterNoInputController = TextEditingController();
  TextEditingController houseNoInputController = TextEditingController();
  TextEditingController assignedUserIDInputController = TextEditingController();

  addHouse()async{
    try {
      var buildingName =  buildingNameInputController.text.trim();
      var houseNo =  houseNoInputController.text.trim();
      var meterNo = meterNoInputController.text.trim();
      var assignedUserID = assignedUserIDInputController.text.trim();
      var res = await http.post(
        Uri.parse(API.addHouse),
        body: {
          "buildingName":  buildingNameInputController.text.trim(),
          "houseNo" : houseNoInputController.text.trim(),
          "meterNo" : meterNoInputController.text.trim(),
          "assignedUserID" : assignedUserIDInputController.text.trim(),
        }
      );
      if(res.statusCode == 200){
        var data = jsonDecode(res.body);
        if(data["Success"]==true) {
          Fluttertoast.showToast(
              msg: "New House (Building Name : $buildingName and House No : $houseNo) added.");
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
        else {
          Fluttertoast.showToast(
              msg: "Could not add House (Building Name : $buildingName and House No : $houseNo). Building Name and House No should be unique.");
        }
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("New house",style: TextStyle(color: Colors.white),),
        leading: CloseButton(
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: (){
               // if(buildingNameFormKey.currentState!.validate() & houseNoFormKey.currentState!.validate()){
               //   addHouse();
               // }
                addHouse();
              },
              icon: const Icon(Icons.check,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
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
                  labelText: "Assign a user",
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  hintText: "Type a userId...",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
