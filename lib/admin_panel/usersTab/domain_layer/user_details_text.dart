import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';

List<String>userDetailsText({
  required User user
}){
  List<String>detailText= [];
  detailText.add("Name : ${user.fullName}");
  detailText.add("Occupation : ${user.occupation}");
  detailText.add("Email : ${user.emailAdress}");
  detailText.add("Account No : ${user.accountNo}");
  detailText.add("Buildin Name : ${user.buildingName}");
  detailText.add("House No : ${user.houseNo}");
  detailText.add("Meter No : ${user.meterNo}");
  return detailText;
}