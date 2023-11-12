

import 'package:e_bill/admin_panel/houseTab/data_layer/house_constants.dart';

class House{
  String  buildingName;
  String  houseNo;
  String  meterNo;
  String  assignedUserID;
  bool typeA;
  bool typeB;
  bool typeS;


  House(
      {
       required this.buildingName,
       required this.houseNo,
       required this.meterNo,
       required this.assignedUserID,
       required this.typeA,
       required this.typeB,
       required this.typeS,
      }
      );

  factory House.fromJson(Map<String,dynamic> json) =>House(
      buildingName: json[buildingname],
      houseNo: json[houseno],
      meterNo: json[meterno],
      assignedUserID: json[assignedUserid],
      typeA: json[aType]=="0"?false:true,
      typeB: json[bType]=="0"?false:true,
      typeS: json[sType]=="0"?false:true,
  );

}


