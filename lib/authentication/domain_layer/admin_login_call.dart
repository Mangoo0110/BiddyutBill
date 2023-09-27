import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/authentication/data_layer/admin_auth/admin_auth_crud.dart';
import 'package:e_bill/authentication/data_layer/admin_auth/admin_auth_model.dart';

Future<Admin?>adminLogin({
  required String email,
  required String password,
})async{
  Admin? admin = await AdminAuthStorage().adminLogin(email: email, password: password);
  return admin;
}