import 'dart:async';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_panel/admin_dashboard.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/add_house.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/authentication/presentation_layer/logIn.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:e_bill/shared_pref/data_layer/shared_pref_appuser_setting.dart';
import 'package:e_bill/user_panel/user_dashboard/domain_layer.dart/get_user_from_local.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    const ProviderScope(child:
     MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


final currentAdminProvider = StateProvider<String?>((ref) => null);
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const LogIn(),
      routes: {
        adminDashboardRoute: (context) => const AdminHome(),
        loginRoute: (context) => const LogIn(),
        userDashboardRoute : (context) => const UserDashboard(),
        
      },
    );
  }
}


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }

