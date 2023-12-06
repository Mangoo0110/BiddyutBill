import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';

Future getPreviousMonthRecord({
  required String previousMonthYear,
  required User user
}) async{
  print(previousMonthYear.toString());
  return await MonthlyRecordStorage().fetchARecordForUser(monthYear: previousMonthYear, user: user);
}