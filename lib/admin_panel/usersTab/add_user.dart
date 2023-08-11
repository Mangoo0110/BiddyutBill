import 'dart:convert';

import 'package:e_bill/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var userIdFormKey = GlobalKey<FormState>();
  var mobileNoFormKey = GlobalKey<FormState>();
  var nameFormKey = GlobalKey<FormState>();
  var assignedHouseIdFormKey = GlobalKey<FormState>();
  TextEditingController userIdInputController = TextEditingController();
  TextEditingController mobileNoInputController = TextEditingController();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController assignedHouseIDInputController =
      TextEditingController();

  AddUser() async {
    try {
      var userId = userIdInputController.text.trim();
      var name = nameInputController.text.trim();
      //var mobileNo = mobileNoInputController.text.trim();
      //var assignedHouseID = assignedHouseIDInputController.text.trim();
      print("pressed\n");
      var res = await http.post(Uri.parse(API.addUser), headers: {
        "Accept": "application/json"
      }, body: {
        "userId": userIdInputController.text.trim(),
        "name": nameInputController.text.trim(),
        "mobileNo": mobileNoInputController.text.trim(),
        "assignedHouseID": assignedHouseIDInputController.text.trim(),
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5,
              msg: "New User (User Id : $userId and Name : $name) added.");
        } else {
          Fluttertoast.showToast(
              msg: "Could not add User (Id : $userId and Name : $name).");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("started");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 20, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 22, 22),
        title: const Text(
          "Add User",
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
                print("ggg\n");
                AddUser();
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
                controller: userIdInputController,
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
                  labelText: "User Id Number",
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
                controller: nameInputController,
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
                  labelText: "Name of User",
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
                controller: mobileNoInputController,
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
                  labelText: "Phone Number",
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
                controller: assignedHouseIDInputController,
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
                  labelText: "Assign to a house",
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
