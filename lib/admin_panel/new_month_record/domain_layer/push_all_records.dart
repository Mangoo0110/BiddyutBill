import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';

  Future<void> pushallRecords(List<MonthlyRecord>records, String monthAndYear)async{
  print("monthyear  $monthAndYear");
  for(int index =0;index<records.length; index++){
    print("printing $index");
   var msg =  await MonthRecordStorage().pushMonthlyRecord(monthYear: monthAndYear, record: records[index]);
   print(msg);
  }
}