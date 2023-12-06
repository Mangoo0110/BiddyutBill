import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';

Future<Map<String,MonthlyRecord?>> fetchYearlyRecordsForUser(List<String>allMonths, List<String>monthYear,User user) async{
  Map<String,MonthlyRecord?>records={};
  for (int index=0; index<12; index++) {
      final record = await MonthlyRecordStorage().fetchARecordForUser(monthYear: monthYear[index], user: user);
      records[allMonths[index]] = record;
  }
  return records;
}