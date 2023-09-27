import 'package:flutter/material.dart';
typedef DecisionCallBack = void Function();
class OkayDialogBox extends StatelessWidget {
  DecisionCallBack onDone;
   OkayDialogBox({super.key,required this.onDone});

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
    backgroundColor: Colors.white,
      scrollable: true,
      content: const Padding(
        padding:  EdgeInsets.all(8.0),
        child: Center(child: Text("Success",style: TextStyle(color: Colors.green,fontSize: 30))),
      ),
      actions: [
        InkWell(
          onTap: (){
            onDone();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(" Done ",style: TextStyle(color: Colors.green,fontSize: 20),),
            ),
          ),
        ),
        
      ],
    );
  
  }
}