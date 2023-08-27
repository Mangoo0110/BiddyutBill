import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
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
  var varsityIdFormKey = GlobalKey<FormState>();
  var occupationFormKey = GlobalKey<FormState>();
  var emailFormKey = GlobalKey<FormState>();
  var fullNameFormKey = GlobalKey<FormState>();
  var accountNoFormKey = GlobalKey<FormState>();
  TextEditingController varsityIdInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController fullNameInputController = TextEditingController();
  TextEditingController occupationInputController = TextEditingController();
  TextEditingController accountNoInputController =
      TextEditingController();

  addUser() async {
    
      var varsityId = varsityIdInputController.text.trim();
      var fullName = fullNameInputController.text.trim();
      var occupation = occupationInputController.text.trim();
      var email = emailInputController.text.trim();
      var accountNo = accountNoInputController.text.trim();
      print("pressed\n");
       
      var user = User(varsityId: varsityId, fullName: fullName, emailAdress: email, accountNo: accountNo, occupation: occupation, buildingName: "", houseNo: "", meteNo: "", isEmailVerified: "false");
      var res = await UserStorage().addOrUpdateUser(user: user);
      if(res==true){
        Future.delayed(const Duration(milliseconds: 500),(){
          Navigator.of(context).pop();
        }); 
      }
  }

  @override
  Widget build(BuildContext context) {
    print("started");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 7, 3),
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
                addUser();
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
            //varsity id textField
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: TextFormField(
                key: varsityIdFormKey,
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
            //Full Name textField
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 15,
              ),
              child: TextFormField(
                key: fullNameFormKey,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: TextFormField(
                key: occupationFormKey,
                controller: occupationInputController,
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
                  labelText: "Occupation...",
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                ),
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            
            //email textField
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 15,
              ),
              child: TextFormField(
                key: emailFormKey,
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
                key: accountNoFormKey,
                controller: accountNoInputController,
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
                  labelText: "Account No",
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  hintText: "Type User's Account No...",
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
