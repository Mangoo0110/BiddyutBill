
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/text_validation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool emailVerified = false;
  bool emailNotVerified = true;
  String varsityId = "";
  String fullName = "";
  String occupation = "";
  String email = "";
  String accountNo = "";
  bool typeA = true;
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

  addUser() async {
    
      print("pressed\n");
       if(await formValidation()){
      fullName = removeWhiteSpace(fullName);
      email = removeWhiteSpace(email);
      accountNo = removeWhiteSpace(accountNo);
      occupation = removeWhiteSpace(occupation);
      var user = User(id: varsityId, fullName: fullName, emailAdress: email, accountNo: accountNo, occupation: occupation, 
      buildingName: "", houseNo: "", meterNo: "", isEmailVerified: emailVerified,typeA: typeA,typeB: typeB,typeS: typeS);
      var res = await UserStorage().addOrUpdateUser(user: user);
      if(res==true){
        Fluttertoast.showToast(msg: "Success, New user added");
        Future.delayed(const Duration(milliseconds: 500),(){
          Navigator.of(context).pop();
        }); 
      }
       }
  }
   Future<bool> formValidation()async{
      
      if(varsityId == ''){
        Fluttertoast.showToast(msg: "VarsityId field can not be empty!!",
          //webBgColor: "linear-gradient(to right, #00000, #00000)",
          );
        return false;
      }

      if(fullName ==''){
        Fluttertoast.showToast(msg: "Full Name field can not be empty!!");
        return false;
      }
      var user = await UserStorage().fetchOneUser(varsityId: varsityId);   
      if(user!=null){
        Fluttertoast.showToast(
              msg:
                  "This user's varsityId already exists. [Varsity Id] should be unique.");
      return false;
      }
      return true;
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
                onChanged: (value) {
                  var len = value.length ;
                  if(len>0){
                  if(value.codeUnitAt(len-1)<"0".codeUnitAt(0)||value.codeUnitAt(len-1)>"9".codeUnitAt(0)){
                    setState(() {
                      varsityIdInputController.text = varsityId;
                    });
                    
                    }
                    else{
                      varsityId = varsityIdInputController.text;
                    }
                  }
                  
                  
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
                validator: (val) {
                  RegExp rg = RegExp(r"^[0-9]", caseSensitive: false);
                  if (val == "") {
                    return "This field can not be empty!";
                  } else if (rg.hasMatch(val!)) {
                    return "Enter Numbers(0-9)..";
                  }
                  return null;
                },
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
