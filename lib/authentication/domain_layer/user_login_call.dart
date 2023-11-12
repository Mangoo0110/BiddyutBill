
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_crud.dart';
import 'package:e_bill/authentication/data_layer/app_user_auth/app_user_auth_model.dart';

Future<User?>userLogin({
  required String email,
  required String password,
})async{
  User? userAuth = await AppUserAuthStorage().login(email: email, password: password);
  if(userAuth!=null){
    User? user = await UserStorage().fetchOneUser(varsityId: userAuth.id);
    return user;
  }
  return null;
}