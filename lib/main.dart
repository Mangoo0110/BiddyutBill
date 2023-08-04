import 'package:e_bill/admin_panel/addHouse.dart';
import 'package:e_bill/admin_panel/admin_Dashboard.dart';
import 'package:e_bill/authentication/logIn.dart';
import 'package:e_bill/authentication/signUp.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          builder: (context,dataSnapshot){
            return const logIn();
          }
      ),
      routes: {
        adminDashboardRoute:(context) => const AdminHome(),
        addHouseRoute: (context) => const AddHouse(),
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

