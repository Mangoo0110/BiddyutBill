import 'package:flutter/material.dart';

class signUp extends StatelessWidget {
  const signUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp",style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,fontSize: 30),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
      ),
    );
  }
}
