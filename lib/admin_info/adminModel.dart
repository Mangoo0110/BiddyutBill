

import 'package:e_bill/admin_info/admin_constants.dart';
import 'package:flutter/material.dart';

class Admin{
  final String  id;
  final String emailAddress;
  final String fullName;
  final String whatJob;
  final String contactNo;

  Admin(
        {
        required this.id,
        required this.emailAddress,
        required this.fullName,
        required this.whatJob,
        required this.contactNo
      }
      );

  factory Admin.fromJson(Map<String,dynamic> json) =>Admin(
      id: json[varsityId],
      emailAddress: json[email],
      fullName: json[fullname],
      whatJob: json[job],
      contactNo:  json[contactno]
  );

  Map<String,dynamic>toJson()=>
      {
        varsityId : id,
        fullname : fullName,
        email : emailAddress,
        job :whatJob,
        contactno : contactNo
      };


}