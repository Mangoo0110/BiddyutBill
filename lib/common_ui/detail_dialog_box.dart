import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
typedef DecisionCallBack = void Function();
class DetailDialogBox extends StatelessWidget {
  String titleText;
  List<String> bodyText;
  DecisionCallBack onOk;
  DetailDialogBox({super.key,required this.titleText, required this.bodyText, required this.onOk});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(titleText,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
       content: Column(
        children: bodyText.map((item) => Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item, style: const TextStyle(color: Colors.black54,fontSize: 20),),
          ),
        )).toList(),
       ),
      actions: [
        InkWell(
          onTap: (){
            onOk();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text(" Done ",style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ],
    );
  }
}