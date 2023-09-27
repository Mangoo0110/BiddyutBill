import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_crud.dart';
import 'package:e_bill/authentication/data_layer/authentication_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyUserEmailAddress extends StatelessWidget {
  
  VerifyUserEmailAddress({super.key});
  bool emailVerifyCode = false;
  Key emailVerifyFormKey = GlobalKey<FormState>();
  TextEditingController emailVerifyTxtfldCntrllr = TextEditingController();
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
                    //otp textfield
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              //padding: EdgeInsets.fromLTRB((size.width-300)*0.9 , size.height * .02, size.width * 0.03, 0.0),
                              child: SizedBox(
                                width: 200 + (size.width*0.2),
                              child: Form(
                                key: emailVerifyFormKey,
                                //input varsity id
                                child: TextFormField(
                                  controller: emailVerifyTxtfldCntrllr,
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
                                    hintText: "Type the sent email verification code...",
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
                              final user = await AppUserAuthStorage().verifyEmailAddress(email: emailVerifyTxtfldCntrllr.text);
                              if(user!=null){

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
          );
        }
      ),
    );
  
  }
}