import 'package:flutter/material.dart';

var defaultColor = Colors.grey[300];
var adminAppBar = AppBar(

);


var adminDrawer = Drawer(
  backgroundColor: defaultColor,
  child: const Column(
    children: [
      ListTile(
        leading: Icon(Icons.home_work,),
        title: Text("H O U S E S"),
      ),
      ListTile(
        leading: Icon(Icons.monetization_on,),
        title: Text("U N I T C O S T"),
      ),
      ListTile(
        leading: Icon(Icons.person_2_rounded,),
        title: Text("U S E R S"),
      ),
      ListTile(
        leading: Icon(Icons.message_outlined,),
        title: Text("C O M P L A I N S"),
      ),
    ],
  ),
);