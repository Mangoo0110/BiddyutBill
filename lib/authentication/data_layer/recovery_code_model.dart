
import 'package:e_bill/authentication/data_layer/authentication_constants.dart';

class RecoverCodeModel{
  final String varsityId;
  final String emailAddress;
  final String recoveryCode;

  RecoverCodeModel({ required this.varsityId, required this.emailAddress, required this.recoveryCode});
  factory RecoverCodeModel.fromJson(Map<String,dynamic> json)=>RecoverCodeModel(
    varsityId: json[varsityid],
    emailAddress: json[email],
    recoveryCode: json[recoverycode]
  );
}