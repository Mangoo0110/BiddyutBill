import 'dart:convert';

class House{
  final  buildingName;
  final  houseNo;
  final  meterNo;
  final  assignedUserID;

  House(
      {
       this.buildingName,
       this.houseNo,
       this.meterNo,
       this.assignedUserID,
      }
      );

  factory House.fromJson(Map<String,dynamic> json) =>House(
      buildingName: json["BuildingName"],
      houseNo: json["HouseNo"],
      meterNo: json["MeterNo"],
      assignedUserID: json["AssignedUserID"]
  );

  Map<String,dynamic>toJson()=>
      {
        "buildingName": buildingName,
        "houseNo" : houseNo,
        "meterNo" : meterNo,
        "assignedUserID" : assignedUserID,
      };


}