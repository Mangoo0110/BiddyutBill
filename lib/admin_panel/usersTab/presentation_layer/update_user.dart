import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_constants.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/text_validation.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatefulWidget {

  

  User userInfo;
  UpdateUser({super.key,required this.userInfo});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  bool emailVerified = false;
  bool emailNotVerified = false;
  String varsityId = "";
  String fullName = "";
  String occupation = "";
  String email = "";
  String accountNo = "";
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
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

  updateUser() async {
    
      if(await formValidation()){
      fullName = removeWhiteSpace(fullName);
      email = removeWhiteSpace(email);
      accountNo = removeWhiteSpace(accountNo);
      occupation = removeWhiteSpace(occupation);
      var user = User(varsityId: widget.userInfo.varsityId, fullName: fullName, emailAdress: email, accountNo: accountNo, occupation: occupation, 
      buildingName: "", houseNo: "", meteNo: "", isEmailVerified: emailVerified,typeA: typeA,typeB: typeB,typeS: typeS);
      var res = await UserStorage().addOrUpdateUser(user: user);
      if(res==true){
        Fluttertoast.showToast(msg: "Success. user Uppaded.");
        Future.delayed(const Duration(milliseconds: 500),(){
          Navigator.of(context).pop();
        }); 
      }
       }
  }
   Future<bool> formValidation()async{

      if(fullName ==''){
        Fluttertoast.showToast(msg: "Full Name field can not be empty!!");
        return false;
      }

      return true;
  }

  getDetails(){
    varsityIdInputController.text = widget.userInfo.varsityId;
    fullNameInputController.text = widget.userInfo.fullName;
    emailInputController.text = widget.userInfo.emailAdress;
    accountNoInputController.text = widget.userInfo.accountNo;
    occupationInputController.text = widget.userInfo.occupation;

  }
  @override
  void initState() {
    // TODO: implement initState
    emailVerified = widget.userInfo.isEmailVerified=="true"?true:false;
    emailNotVerified = widget.userInfo.isEmailVerified!="true"?true:false;
    varsityId = widget.userInfo.varsityId;
    fullName = widget.userInfo.fullName;
    occupation = widget.userInfo.occupation;
    accountNo = widget.userInfo.accountNo;
    email = widget.userInfo.emailAdress;
    typeA = widget.userInfo.typeA;
    typeB = widget.userInfo.typeB;
    typeS = widget.userInfo.typeS;
    super.initState();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    //varsityIdInputController.text = "";
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 7, 3),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 22, 22),
        title: const Text(
          "Update User",
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
                readOnly: true,
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
                onChanged: (value) {
                  fullName = fullNameInputController.text;
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
                onChanged: (value) {
                  occupation = occupationInputController.text;
                },
                decoration: const InputDecoration(
                  labelText: "Occupation",
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
                onChanged: (value) {
                  email = emailInputController.text;
                  
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
                 onChanged: (value) {
                  accountNo = accountNoInputController.text;
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
             Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text("User Type :",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    Row(
                      
                      children: [
                         Padding(
                          padding:  const EdgeInsets.all(8.0),
                          child: Text("A",style: TextStyle(color: (typeA==true)?Colors.white: Colors.white60,fontSize: 20),),
                        ),
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                            Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("B",style: TextStyle(color: (typeB==true)?Colors.white: Colors.white60,fontSize: 20),),
                           ),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                            Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("S",style: TextStyle(color: (typeS==true)?Colors.white: Colors.white60,fontSize: 20),),
                           ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text("Email Verified?",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    Row(
                      
                      children: [
                         Padding(
                          padding: const  EdgeInsets.all(8.0),
                          child: Text("Yes",style: TextStyle(color: (emailVerified==true)?Colors.white: Colors.white60,fontSize: 20),),
                        ),
                        Checkbox(
                          value: emailVerified,
                         onChanged: (val){
                         
                          setState(() {
                          emailVerified = val!;
                          emailNotVerified = !emailVerified;
                          });
                         }
                         ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("No",style: TextStyle(color: (emailNotVerified==true)?Colors.white: Colors.white60,fontSize: 20),),
                           ),
                          Checkbox(
                            value: emailNotVerified,
                           onChanged: (val){
                            
                            setState(() {
                            emailNotVerified = val!;
                            emailVerified = !emailNotVerified;
                            });
                           }
                           ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          
          ],
        ),
      ),
    );
  }
}
