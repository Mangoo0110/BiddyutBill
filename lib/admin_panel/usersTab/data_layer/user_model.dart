
import 'package:e_bill/admin_panel/usersTab/data_layer/user_constants.dart';

class User{
   String varsityId;
   String fullName;
   String emailAdress;
   String accountNo;
   String occupation;
   String buildingName;
   String houseNo;
   String meteNo;
   String isEmailVerified;

  User(
      {
      required this.varsityId,
      required this.fullName,
      required this.emailAdress,
      required this.accountNo,
      required this.occupation,
      required this.buildingName,
      required this.houseNo,
      required this.meteNo,
      required this.isEmailVerified,
      }
      );

  factory User.fromJson(Map<String,dynamic> json) =>User(
      varsityId: json[varsityid].toString(),
      fullName: json[name].toString(),
      emailAdress: json[email].toString(),
      accountNo: json[accountno].toString(),
      occupation: json[occupatioN].toString(),
      buildingName: json[buildingname].toString(),
      houseNo: json[houseno].toString(),
      meteNo:  json[meterno].toString(),
      isEmailVerified: json[isEmailverified].toString()
  );

}