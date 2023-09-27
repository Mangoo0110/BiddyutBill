
import 'dart:async';
import 'dart:convert';

import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/authentication/domain_layer/admin_login_call.dart';
import 'package:e_bill/authentication/domain_layer/user_login_call.dart';
import 'package:e_bill/authentication/presentation_layer/admin_forgot_password.dart';
import 'package:e_bill/authentication/presentation_layer/verify_user_email_address.dart';
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
  bool submittedEmailId = false;
  Key formEmailKey = GlobalKey<FormState>();
  Key formPasswordKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();





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
                    
                      //email textfield
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        //padding: EdgeInsets.fromLTRB((size.width-300) * 0.9, size.height * .05, size.width * 0.03, 0.0),
                        child: SizedBox(
                          width: 200+(size.width*0.2),
                        child: Form(
                          key: formEmailKey,
                          child: TextFormField(
                            controller: emailController,
                            validator: (val) =>
                            (val == "")
                                ? "This Field Is Empty, Duck!!"
                                : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_person_rounded,
                                color: Colors.orange,
                              ),
                              hintText: "Email...",
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
                      //
                      //password textfield
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                            child: SizedBox(
                              width: 200 + (size.width*0.2),
                            child: Form(
                              key: formPasswordKey,
                              //input varsity id
                              child: TextFormField(
                                obscureText: true,
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
                          ),
                           //
                      //login button
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, size.height * .02, size.width * 0, 0.0),
                        child: SizedBox(
                          width: 100+ (size.width*0.1),
                          height: 50,
                        child: Material(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: ()async{
                                if(adminbtn){
                                  final admin = await adminLogin(email: emailController.text, password: passwordController.text);
                                  if(admin!=null){
                                  Future.delayed(const Duration(milliseconds: 500),(){
                                    Navigator.of(context).pushNamedAndRemoveUntil(adminDashboardRoute, (route) => false);
                                  });
                                  }
                                  
                                }
                                else if(userbtn){
                                  final user = await userLogin(email: emailController.text, password: passwordController.text);
                                  if(user!=null){
                                    Future.delayed(const Duration(milliseconds: 500),(){
                                      Navigator.of(context).pushNamedAndRemoveUntil(userDashboardRoute, (route) => false);
                                    });
                                  }
                                }
                              },
                              child: const Center(child:  Text("LOG  IN",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
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
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AdminForgotPassword()));
                          },
                          child: const Text("Forgot password? Login with one time temporary code",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,),),
                        ),
                      )
                    
                        ],
                      ),
                     
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
