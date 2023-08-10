import 'dart:async';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_panel/admin_Dashboard.dart';
import 'package:e_bill/admin_panel/houseTab/houseView/addHouse.dart';
import 'package:e_bill/authentication/logIn.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.


  bool adminExist = false;
  String adId = '';
  Admin? thisAdmin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LogIn(),
      routes: {
        adminDashboardRoute:(context) => const AdminHome(),
        addHouseRoute: (context) => const AddHouse(),
        loginRoute: (context) =>const AdminHome(),
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

