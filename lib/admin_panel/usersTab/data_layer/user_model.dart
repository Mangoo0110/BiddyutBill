
import 'package:e_bill/admin_panel/usersTab/data_layer/user_constants.dart';

class User{
   String id;
   String fullName;
   String emailAdress;
   String accountNo;
   String occupation;
   String buildingName;
   String houseNo;
   String meterNo;
   bool isEmailVerified;
   bool typeA;
   bool typeB;
   bool typeS;

  User(
      {
      required this.id,
      required this.fullName,
      required this.emailAdress,
      required this.accountNo,
      required this.occupation,
      required this.buildingName,
      required this.houseNo,
      required this.meterNo,
      required this.isEmailVerified,
      required this.typeA,
      required this.typeB,
      required this.typeS,
      }
      );

  factory User.fromJson(Map<String,dynamic> json) =>User(
      id: json[varsityid].toString(),
      fullName: json[name].toString(),
      emailAdress: json[email].toString(),
      accountNo: json[accountno].toString(),
      occupation: json[occupatioN].toString(),
      buildingName: json[buildingname].toString(),
      houseNo: json[houseno].toString(),
      meterNo:  json[meterno].toString(),
      isEmailVerified: json[isEmailverified].toString().toLowerCase()=="true"?true:false,
      typeA: json[aType]=="0"?false:true,
      typeB: json[bType]=="0"?false:true ,
      typeS: json[sType]=="0"?false:true ,
  );
  
  Map<String,dynamic>toJson(){
    return {
      varsityid : id,
      name : fullName,
      email : emailAdress,
      accountno : accountNo,
      occupatioN : occupation,
      buildingname :buildingName,
      houseno : houseNo,
      meterno : meterNo,
      isEmailverified : isEmailVerified,
      aType :typeA,
      bType :typeB,
      sType :typeS
    };
  }

}