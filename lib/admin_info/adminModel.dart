import 'dart:convert';

class Admin{
  final String  id;
  final String email;
  final String fullname;

  Admin(
        {
        required this.id,
        required this.email,
        required this.fullname,
      }
      );

  factory Admin.fromJson(Map<String,dynamic> json) =>Admin(
      id: json["varsityID"],
      email: json["email"],
      fullname: json["fullName"],
  );

  Map<String,dynamic>toJson()=>
      {
        "varsityID" : id,
        "email" : email,
        "fullName" : fullname,
      };


}