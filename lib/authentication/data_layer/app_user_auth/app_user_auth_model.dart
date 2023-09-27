import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_constants.dart';

class AppUserAuth{
  String varsityId;
  String password;
  String fullName;
  String email;
  String isEmailVerified;
  String otp;
  AppUserAuth({required this.varsityId, required this.password, required this.fullName, required this.email,
            required this.isEmailVerified, required this.otp});
  factory AppUserAuth.fromJson(Map<String, dynamic>json)=> AppUserAuth(
    varsityId: json[varsityid],
    password: json[pwd],
    fullName: json[fullname],
    email:  json[emailAddress],
    isEmailVerified: json[emailVerifiedOrNot],
    otp: json[oneTimePassword]
  );
}