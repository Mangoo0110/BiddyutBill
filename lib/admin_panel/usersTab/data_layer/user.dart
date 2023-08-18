import 'dart:convert';

class User{
  final String id;
  final String fullName;
  final String email;
  final String assignedMeterNo;
  final String houseAddress;

  User(
      {
      required this.id,
      required this.fullName,
      required this.email,
      required this.assignedMeterNo,
      required this.houseAddress, 
      }
      );

  factory User.fromJson(Map<String,dynamic> json) =>User(
      id: json["varsity_id"],
      fullName: json["full_name"],
      email: json["email"],
      assignedMeterNo: json["assignedMeterNo"],
      houseAddress: json["house_address"],
  );

}