import 'package:e_bill/authentication/data_layer/admin_auth/admin_auth_constants.dart';

class AdminAuth{
  String varsityId;
  String password;
  String fullName;
  String email;
  String isEmailVerified;
  String otp;
  AdminAuth({required this.varsityId, required this.password, required this.fullName, required this.email,
            required this.isEmailVerified, required this.otp});
            
  factory AdminAuth.fromJson(Map<String, dynamic>json)=> AdminAuth(
    varsityId: json[varsityid],
    password: json[pwd],
    fullName: json[fullname],
    email:  json[emailAddress],
    isEmailVerified: json[emailVerifiedOrNot],
    otp: json[oneTimePassword]
  );
}