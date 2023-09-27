import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';

Future<List<User>> getSpecificUsers({required searchedText,  bool? typeA,  bool? typeB,  bool? typeS,  bool? typeAll}) async {
    List<User> allUsers = await UserStorage().fetchAllUsers();
     List<User> filteredRecord= [];
      for(var user in allUsers) {
      if( user.fullName.toString().toLowerCase().contains(searchedText.toLowerCase())){
        filteredRecord.add(user);
      }
     }
     if(typeA == true){
      List<User> aTypeUsers = [];
      for(int index = 0; index<filteredRecord.length; index++){
      if(filteredRecord[index].typeA==typeA){
        aTypeUsers.add(filteredRecord[index]);
      } 
    }
    return aTypeUsers;
     }
     if(typeB == true){
      List<User> bTypeUsers = [];
      for(int index = 0; index<filteredRecord.length; index++){
        if(filteredRecord[index].typeB==typeB){
          bTypeUsers.add(allUsers[index]);
        }
      }
      return bTypeUsers;
     }
     if(typeS == true){
      List<User> sTypeUsers = [];
      for(int index = 0; index<filteredRecord.length; index++){
        if(filteredRecord[index].typeS==typeS){
          sTypeUsers.add(filteredRecord[index]);
        }
      }
      return sTypeUsers;
     }
     else{
      return filteredRecord;
     }
     
  }