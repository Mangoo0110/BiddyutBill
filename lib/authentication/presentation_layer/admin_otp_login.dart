import 'package:e_bill/authentication/data_layer/admin_auth/admin_auth_crud.dart';
import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_crud.dart';
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


class AdminOtpLogin extends StatefulWidget {
  const AdminOtpLogin({super.key});

  @override
  State<AdminOtpLogin> createState() => _AdminOtpLoginState();
}

class _AdminOtpLoginState extends State<AdminOtpLogin> {
  bool askForOTP = false;
  Key otpFormKey = GlobalKey<FormState>();
  TextEditingController otpTextEditingController = TextEditingController();
  Key emailFormKEy = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();

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
                      (askForOTP==false)?
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                                child: SizedBox(
                                  width: 200 + (size.width*0.2),
                                child: Form(
                                  key: emailFormKEy,
                                  //input varsity id
                                  child: TextFormField(
                        
                                    controller: emailTextEditingController,
                                    validator: (val) =>
                                    (val == "")
                                        ? "This Field Can Not Be Empty, Duck!!"
                                        : null,
                                    
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_rounded,
                                        color: Colors.orange,
                        
                                      ),
                                      hintText: "Type your admin app email...",
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
                                          var dataModel = await AdminAuthStorage().sendAdminOTP(email: emailTextEditingController.text);
                                          if(dataModel==true){
                                          //var success = await AuthenticationStorage().sendAdminRecoveryEmail(recoverAdmin: dataModel);
                                            Fluttertoast.showToast(msg: "OTP sent to your app email address");
                                            setState(() {
                                            askForOTP =true;
                                            });
                                          }
                                          else{
                                            Fluttertoast.showToast(msg: "Failed!!");
                                            setState(() {
                                            askForOTP =false;
                                            });
                                          }
                                      },
                                      child: const Center(child:  Text("Send OTP to my email",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                ),
                              ),
                            ],
                          )
                          
                      :
                      // textfield
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                                child: SizedBox(
                                  width: 200 + (size.width*0.2),
                                child: Form(
                                  key: otpFormKey,
                                  //input varsity id
                                  child: TextFormField(
                        
                                    controller: otpTextEditingController,
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
                                      hintText: "Type your otp login code...",
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
                                        var success = await AdminAuthStorage().validateAdminOTP(email: emailTextEditingController.text, otp: otpTextEditingController.text);
                                        if(success==true){
                                          Future.delayed(const Duration(milliseconds: 1000),(){
                                            Navigator.of(context).pushNamed(adminDashboardRoute);
                                          });
                                        }
                                      },
                                      child: const Center(child:  Text("Proceed",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
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