import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/shared_pref/data_layer/shared_pref_appuser_setting.dart';

Future<User?>publicUserFromPersistantStorage()async{
  AppPersistantStorage storage = AppPersistantStorage();
  await storage.init();
  final gg = await storage.CurrentAppUserWho();
  print(gg);
  return storage.getCurrentAppUserPublic();
}