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
      fullName: json["full_name"],
      email: json["email"],
      assignedMeterNo: json["assignedMeterNo"]
  );

  Map<String,dynamic>toJson()=>
      {
        "varsity_id": id,
        "full_name" : fullName,
        "email" : email,
        "AssignedMeterNo" : assignedMeterNo,
      };
}