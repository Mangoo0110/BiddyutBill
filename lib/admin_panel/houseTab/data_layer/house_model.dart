

import 'package:e_bill/admin_panel/houseTab/data_layer/house_constants.dart';

class House{
  String  buildingName;
  String  houseNo;
  String  meterNo;
  String  assignedUserID;

  House(
      {
       required this.buildingName,
       required this.houseNo,
       required this.meterNo,
       required this.assignedUserID,
      }
      );

  factory House.fromJson(Map<String,dynamic> json) =>House(
      buildingName: json[buildingname],
      houseNo: json[houseno],
      meterNo: json[meterno],
      assignedUserID: json[assignedUserid],
  );

}