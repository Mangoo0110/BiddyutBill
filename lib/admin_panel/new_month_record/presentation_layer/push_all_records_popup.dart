import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:flutter/material.dart';

class pushRecordUI extends StatefulWidget {
  final List<MonthlyRecord> recordList;
  const pushRecordUI({Key? key,required this.recordList}):super(key: key);

  @override
  State<pushRecordUI> createState() => _pushRecordUIState();
}

class _pushRecordUIState extends State<pushRecordUI> {
  int pushedCounter = 0;
  String msg ="";
  int _index = 0;
  List<MonthlyRecord>passedRecordList= [];
  @override
  void initState() {
    // TODO: implement initState
    passedRecordList = widget.recordList;
    super.initState();
  }
  Future<void> pushallRecords(List<MonthlyRecord>records, String monthAndYear)async{
  for(int index =_index;index<records.length; index++){
   msg =  await MonthRecordStorage().pushMonthlyRecord(monthYear: monthAndYear, record: records[index]);
   print(msg);
  }
}
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
            Text("Record pushed: $pushedCounter"),
            Text("")
        ],
      )
    );
  }
}