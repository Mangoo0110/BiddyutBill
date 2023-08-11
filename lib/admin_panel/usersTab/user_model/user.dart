import 'dart:convert';

class User{
  final  id;
  final  fullName;
  final  email;
  final  assignedMeterNo;

  User(
      {
       this.id,
       this.fullName,
       this.email,
       this.assignedMeterNo,
      }
      );

  factory User.fromJson(Map<String,dynamic> json) =>User(
      id: json["varsity_id"],
      fullName: json["full_Name"],
      email: json["email"],
      assignedMeterNo: json["assignedMeterNo"]
  );

  Map<String,dynamic>toJson()=>
      {
        "varsityId": id,
        "full_Name" : fullName,
        "email" : email,
        "AssignedMeterNo" : assignedMeterNo,
      };
}