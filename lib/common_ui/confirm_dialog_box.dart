import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
typedef DecisionCallBack = void Function();
class ConfirmDialogBox extends StatelessWidget {
  String titleText;
  String bodyText;
  DecisionCallBack onConfirm,onCancel;
  ConfirmDialogBox({super.key,required this.titleText, required this.bodyText, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(titleText,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(bodyText,style: const TextStyle(color: Colors.black54,fontSize: 20)),
      ),
      actions: [
        InkWell(
          onTap: (){
            onCancel();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(" Cancel ",style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
          ),
        ),
        InkWell(
          onTap: (){
            onConfirm();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(" Confirm ",style: TextStyle(color: Colors.green,fontSize: 20),),
            ),
          ),
        ),
        
      ],
    );
  
  }
}