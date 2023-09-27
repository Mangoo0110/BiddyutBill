import 'package:e_bill/authentication/data_layer/authentication_crud.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart' ;


class AdminForgotPassword extends StatefulWidget {
  const AdminForgotPassword({super.key});

  @override
  State<AdminForgotPassword> createState() => _AdminForgotPasswordState();
}

class _AdminForgotPasswordState extends State<AdminForgotPassword> {
  bool askForRecoveryCode = false;
  Key formcodeRecoveryKey = GlobalKey<FormState>();
  TextEditingController codeRecoveryController = TextEditingController();
  Key varsityIdKey = GlobalKey<FormState>();
  TextEditingController varsityIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,cons) {
          
          return Container(
            color: Colors.blueGrey.shade900,
            height: cons.maxHeight,
            width: cons.maxWidth,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: cons.minHeight,
                  minWidth: cons.minWidth,
                ),
            
                child: Container(
                  
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 160, 0, 0),
                        // child: ConstrainedBox(constraints: BoxConstraints(
                        //  // minHeight: cons.minHeight,
                        //  // minWidth: cons.minWidth,
                        // ),
                        child: SizedBox(
                            height: 150,
                            child: Image.asset("images/e_bill.png",color: Colors.orange,)
                         ),
                        
                    
                      ),
                      //varsity ID textfield
                      (askForRecoveryCode==false)?
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                                child: SizedBox(
                                  width: 200 + (size.width*0.2),
                                child: Form(
                                  key: varsityIdKey,
                                  //input varsity id
                                  child: TextFormField(
                        
                                    controller: varsityIdController,
                                    validator: (val) =>
                                    (val == "")
                                        ? "This Field Can Not Be Empty, Duck!!"
                                        : null,
                                    
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_rounded,
                                        color: Colors.orange,
                        
                                      ),
                                      hintText: "Type your varsity id...",
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
                              ),
                              Padding(
                        padding: EdgeInsets.fromLTRB(0, size.height * .02, size.width * 0, 0.0),
                        child: SizedBox(
                          width: 100+ (size.width*0.18),
                          height: 50,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: ()async{
                                var dataModel = await AuthenticationStorage().askApiForRecoveryCode(varsityId: varsityIdController.text);
                                if(dataModel!=null){
                                var success = await AuthenticationStorage().sendAdminRecoveryEmail(recoverAdmin: dataModel);
                                if(success==true){
                                  Fluttertoast.showToast(msg: "Code sent to your app email address");
                                  setState(() {
                                  askForRecoveryCode =true;
                                });
                                }
                                
                                }
                              },
                              child: const Center(child:  Text("Send recovery code to my email",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        ),
                      ),
                      
                            ],
                          )
                          
                      :
                      //password textfield
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                                child: SizedBox(
                                  width: 200 + (size.width*0.2),
                                child: Form(
                                  key: formcodeRecoveryKey,
                                  //input varsity id
                                  child: TextFormField(
                        
                                    controller: codeRecoveryController,
                                    validator: (val) =>
                                    (val == "")
                                        ? "This Field Can Not Be Empty, Duck!!"
                                        : null,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(7),
                                    ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_rounded,
                                        color: Colors.orange,
                        
                                      ),
                                      hintText: "Type your temporary login code...",
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
                              ),
                              Padding(
                        padding: EdgeInsets.fromLTRB(0, size.height * .02, size.width * 0, 0.0),
                        child: SizedBox(
                          width: 100+ (size.width*0.1),
                          height: 50,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: ()async{
                                var success = await AuthenticationStorage().validateRecoveryCode(varsityId: varsityIdController.text, recoveryCode: codeRecoveryController.text);
                                if(success==true){
                                  Navigator.of(context).pushNamed(adminDashboardRoute);
                                }
                              },
                              child: const Center(child:  Text("Submit",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        ),
                      ),
                      
                            ],
                          ),
                          
                      //
                      //login button
                      
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  
  }
}