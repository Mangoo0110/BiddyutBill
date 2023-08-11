import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/user_model/user.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatelessWidget {

  

  User userInfo;
  UpdateUser({super.key,required this.userInfo});

  var userIdFormKey = GlobalKey<FormState>();

  var mobileNoFormKey = GlobalKey<FormState>();

  var nameFormKey = GlobalKey<FormState>();

  var assignedHouseIdFormKey = GlobalKey<FormState>();

  TextEditingController varsityIdInputController = TextEditingController();

  TextEditingController emailInputController = TextEditingController();

  TextEditingController fullNameInputController = TextEditingController();

  TextEditingController assignedMeterNoInputController =
      TextEditingController();

  updateUser() async {
    try {
      var varsityId = varsityIdInputController.text.trim();
      var full_Name= fullNameInputController.text.trim();
      var email = emailInputController.text.trim();
      var assignedMeterNo = assignedMeterNoInputController.text.trim();
      print("pressed\n");
      var res = await http.post(Uri.parse(API.addUser), headers: {
        "Accept": "application/json"
      }, body: {
        "varsity_id": varsityId,
        "full_name": full_Name,
        "email": emailInputController.text.trim(),
        "assignedMeterNo": assignedMeterNoInputController.text.trim(),
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5,
              msg: "New User (User Id : $varsityId and Name : $full_Name) added.");
        } else {
          Fluttertoast.showToast(
              msg: "Could not add User (Id : $varsityId and Name : $full_Name).");
        }
      }
    } catch (e) {
      print(e);
    }
  }
  void getUserInfo(){
    fullNameInputController.text = userInfo.fullName;
    print(fullNameInputController.text);
    varsityIdInputController.text = userInfo.id;
    print(userInfo.id);
    emailInputController.text = userInfo.email;
    assignedMeterNoInputController.text = userInfo.assignedMeterNo;

  }
  @override
  Widget build(BuildContext context) {
    print("started");
    getUserInfo();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 22, 8),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 3, 30, 7),
        title: const Text(
          "Update User Record",
          style: TextStyle(color: Colors.white),
        ),
        leading: CloseButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                updateUser();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Category textField
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: TextFormField(
                key: userIdFormKey,
                controller: varsityIdInputController,
                validator: (val) {
                  RegExp rg = RegExp(r"^[0-9]", caseSensitive: false);
                  if (val == "") {
                    return "This field can not be empty!";
                  } else if (rg.hasMatch(val!)) {
                    return "Enter Numbers(0-9)..";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Varsity Id Number",
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
                horizontal: 15,
              ),
              child: TextFormField(
                key: nameFormKey,
                controller: fullNameInputController,
                validator: (val) {
                  RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                  if (val == "") {
                    return "This field can not be empty!";
                  } else if (rg.hasMatch(val!)) {
                    return "Enter character as (a-z),(0-9)..";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Full Name",
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
                horizontal: 15,
              ),
              child: TextFormField(
                key: mobileNoFormKey,
                controller: emailInputController,
                validator: (val) {
                  RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                  if (val == "") {
                    return "This field can not be empty!";
                  } else if (rg.hasMatch(val!)) {
                    return "Enter character as (a-z),(0-9)..";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
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
                horizontal: 15,
              ),
              child: TextFormField(
                key: assignedHouseIdFormKey,
                controller: assignedMeterNoInputController,
                validator: (val) {
                  RegExp rg = RegExp(r"^[a-z0-9]", caseSensitive: false);
                  if (val == "") {
                    return "This field can not be empty!";
                  } else if (rg.hasMatch(val!)) {
                    return "Enter character as (a-z),(0-9)..";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Meter No",
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  hintText: "Type a Meter No...",
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
