import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:flutter/material.dart';

class RecordDetails extends StatelessWidget {

  MonthlyRecord record;
  String monthOfRecord;
  RecordDetails({
    Key? key,
    required this.monthOfRecord,
    required this.record
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(monthOfRecord),
      content: SingleChildScrollView(
        child: Column(
          children: [
            customDuoLabel("Name : ", record.fullName, Colors.black, Colors.black),
            customDuoLabel("Address : ", record.houseAddress, Colors.black, Colors.black),
            customDuoLabel("Meter No : ", record.meterno, Colors.black, Colors.black),
            customDuoLabel("Previous Meter Reading : ", record.previousmeterReading.toString(), Colors.black, Colors.black),
            customDuoLabel("Present Meter Reading : ", record.presentmeteRreading.toString(), Colors.black, Colors.black),
            customDuoLabel("Consumed Unit : ", record.usedunit.toString(), Colors.black, Colors.black),
            const Divider(),
            customDuoLabel("Electric Charge(Tk) : ", record.unitcostTk.toString(), Colors.black, Colors.black),
            customDuoLabel("Demand Charge(Tk) : ", record.demandchargeTk.toString(), Colors.black, Colors.black),
            const Divider(),
            customDuoLabel("Principle Amount(Tk) : ", record.firsttotalTk.toString(), Colors.black, Colors.black),
            customDuoLabel("Vat Percentage : ", record.vatTk.toString() + "%", Colors.black, Colors.black),
            const Divider(),
            customDuoLabel("Bill Month Total(Tk) : ", record.secondtotalTk.toString(), Colors.black, Colors.black),
            customDuoLabel("Total amount to be paid(Tk) : ", record.finaltotalTk.toString(), Colors.black, Colors.black),
          ],
          
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(4),
          ),
            child: TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("Done",style: TextStyle(color: Colors.black,fontSize: 17),)),
          ),
        )
      ],
    );
  }
  Widget customDuoLabel(String label1,String label2, Color color1, Color color2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label1,style: TextStyle(color: color1,fontSize: 17),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label2,style: TextStyle(color: color2,fontSize: 17),),
        ),
      ],
    );
  }
}