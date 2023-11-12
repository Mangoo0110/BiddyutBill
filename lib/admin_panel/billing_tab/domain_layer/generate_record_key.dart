import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';

String generateRecordKey(MonthlyRecord record){
  return record.buildingName + record.houseNo;
}