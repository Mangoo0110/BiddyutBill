import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/send_user_monthly_bill_email.dart';

  Future<void> pushallRecords(List<MonthlyRecord>records, String monthAndYear)async{
  print("monthyear  $monthAndYear");
  for(int index =0;index<records.length; index++){
    print("printing $index");
   var msg =  await MonthRecordStorage().pushMonthlyRecord(monthYear: monthAndYear, record: records[index]);
   print(msg);
  //  var sendOrNot = await monthly_bill_email(record: records[index], monthAndYear: monthAndYear);
  //  print(records[index].fullName + "email sent: ");
  //  print(sendOrNot);
  }
}