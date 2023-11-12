import 'dart:async';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/authentication/presentation_layer/logIn.dart';
import 'package:e_bill/user_panel/constants/ui_colors.dart';
import 'package:e_bill/user_panel/user_dashboard/domain_layer.dart/get_user_from_local.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/main_content.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/sidebar.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  User? user;
  late Timer _timer;
  int count = 0;
  Future <void>getUser()async{
    user = await publicUserFromPersistantStorage();
   // print(user);
  }
  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
      getUser();
      if(count>6||user!=null)_timer.cancel();
      });
      
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer.isActive)_timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    count++;
    if(user==null){
      if(count>5){
          _timer.cancel();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogIn()), (route) => false);
      }
    }
    count =0;
    _timer.cancel;
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Row(children: [
        Expanded(
          flex: 20,
          child: UserDashboardMainContent(user: user),
        ),
        Expanded(
          flex: 7,
          child: UserSideBar(user: user),
        ),
      ]),
    );
  }

}