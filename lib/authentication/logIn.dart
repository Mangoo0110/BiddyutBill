
import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_info/adminPreferences.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart' ;



class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => LogInState();
}

class LogInState extends State<LogIn> {

  bool adminbtn=false;
  bool userbtn=false;
  Key formVarsityIdKey = GlobalKey<FormState>();
  Key formPasswordKey = GlobalKey<FormState>();
  TextEditingController vIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




  adminLogIn()async{
    try{
      var varsityId = vIdController.text.trim();
      var password = passwordController.text.trim();
      print("$varsityId , $password");
      var res = await http.post(
          Uri.parse(API.adminLogIn),
          headers: {"Accept":"application/json"},
          body: {
            "varsityID": varsityId,
            "password": password,
          }
      );
      print(res.statusCode);
      if(res.statusCode == 200){
        print("success");
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin["Success"]==true){

          Fluttertoast.showToast(msg: "Congrats, You are Logged In successfully");
          final data =resBodyOfLogin["AdminAuth"];
          //print(data);
          Admin adminInfo = Admin.fromJson(data);
          // CurrrentAdmin.setCurrentAdmin(adminInfo);
          // CurrrentAdmin().setLoggedIn(setter: true);
          Future.delayed(
             const Duration(milliseconds: 2000),()
          {
            Navigator.pushNamedAndRemoveUntil(context, adminDashboardRoute, (route) => false);
          }
          );
        }
        else{
          print(resBodyOfLogin["Success"]);
          Fluttertoast.showToast(msg: "Wrong Credentials!!");
        }
      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,cons) {
          return Container(
            color: Colors.blueGrey.shade900,
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: cons.minHeight,
                  minWidth: cons.minWidth,

                ),

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 160, 0, 0),
                      child: ConstrainedBox(constraints: BoxConstraints(
                        minHeight: cons.minHeight,
                        minWidth: cons.minWidth,
                      ),
                      child: Container(
                          height: 150,
                          child: Image.asset("images/e_bill.png",color: Colors.orange,)
                       ),
                      ),

                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * .02,
                            horizontal: size.width * .03),
                        child: Row(
                          children: [
                            Center(child: Text("Who are you? ", style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * .04),)),
                            InkWell(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        userbtn = true;
                                        adminbtn = false;
                                      });
                                    },
                                    icon: userbtn == true
                                        ? const Icon(
                                      Icons.check_box_rounded,
                                      color: Colors.orange,)
                                        : const Icon(
                                        Icons.check_box_outline_blank),
                                  ),
                                  Container(

                                    decoration: (userbtn == false)
                                        ? const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.grey,
                                    )
                                        :
                                    const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.white,
                                    )
                                    ,
                                    child: TextButton(onPressed: () {
                                      setState(() {
                                        userbtn = true;
                                        adminbtn = false;
                                      });
                                    },
                                      child: Text("User", style: TextStyle(
                                          fontSize: size.width * .03,
                                          fontWeight: FontWeight.bold,
                                          color: (userbtn == true) ? Colors.orange
                                              .shade800 : Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        userbtn = false;
                                        adminbtn = true;
                                      });
                                    },
                                    icon: adminbtn == true
                                        ? const Icon(
                                      Icons.check_box_rounded,
                                      color: Colors.orange,)
                                        : const Icon(
                                        Icons.check_box_outline_blank),
                                  ),
                                  Container(

                                    decoration: (adminbtn == false)
                                        ? const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.grey,
                                    )
                                        :
                                    const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.white,
                                    )
                                    ,
                                    child: TextButton(onPressed: () {
                                      setState(() {
                                        userbtn = false;
                                        adminbtn = true;
                                      });
                                    },
                                      child: Text("Admin", style: TextStyle(
                                          fontSize: size.width * .03,
                                          fontWeight: FontWeight.bold,
                                          color: (adminbtn == true) ? Colors.orange
                                              .shade800 : Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //varsity ID textfield
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.03, size.height * .05, size.width * 0.03, 0.0),
                      child: Form(
                        key: formVarsityIdKey,
                        //input varsity id
                        child: TextFormField(
                          controller: vIdController,
                          validator: (val) =>
                          (val == "")
                              ? "This Field Is Empty, Duck!!"
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_person_rounded,
                              color: Colors.orange,
                            ),
                            hintText: "Varsity Id...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),

                        ),
                      ),
                    ),
                    //
                    //password textfield
                    Padding(
                      padding: EdgeInsets.fromLTRB(size.width * 0.03, size.height * .02, size.width * 0.03, 0.0),
                      child: Form(
                        key: formPasswordKey,
                        //input varsity id
                        child: TextFormField(

                          controller: passwordController,
                          validator: (val) =>
                          (val == "")
                              ? "This Field Can Not Be Empty, Duck!!"
                              : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key_rounded,
                              color: Colors.orange,

                            ),
                            hintText: "Password...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),

                        ),
                      ),
                    ),
                    //
                    //login button
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height * .02, size.width * 0, 0.0),
                      child: Material(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: (){
                              if(adminbtn){
                                adminLogIn();
                                //Navigator.of(context).pushNamedAndRemoveUntil(adminPanelRoute, (route) => false);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * .2),
                              child: const Text("Log In",style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold),),
                            ),
                        ),
                      ),
                    ),
                    //
                    //forgot password button
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        splashColor: Colors.white,
                        //highlightColor: Colors.grey,
                        onTap: (){},
                        child: const Text("Forgotten password ?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
