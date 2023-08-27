import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';

Future<List<House>> getAllHouses() async {
    List<House>allHouses = [];
    allHouses = await HouseStorage().fetchAllHouses();
    return allHouses;
  }

Future <List<User>> getAllUsers()async{
  return await UserStorage().fetchAllUsers();
}
Future<List<User>> getAvailableUsers()async{
  var allUsers = await getAllUsers();
  List<User> availableUsers = [];
  for(var user in allUsers){
    if(user.buildingName==""&&user.houseNo == ""){
      availableUsers.add(user);
    }
  }
  return availableUsers;
}
Future<List<User>> getSearchedUser(String searchText) async{
   var allUsers = await getAvailableUsers();
    List<User>searcheMatchedUsers = [];
    for(int index = 0; index<allUsers.length; index++){
      if(allUsers[index].varsityId.toLowerCase().contains(searchText.toLowerCase())){
        searcheMatchedUsers.add(allUsers[index]);
      }
    }
    return searcheMatchedUsers;
  }

  Future<List<User>> getSearchedUserExceptUser({required  searchText, required String userId}) async{
   var allUsers = await getAvailableUsers();
    List<User>searcheMatchedUsers = [];
    for(int index = 0; index<allUsers.length; index++){
      if(allUsers[index].varsityId.toLowerCase().contains(searchText.toLowerCase())&& allUsers[index].varsityId!=userId){
        searcheMatchedUsers.add(allUsers[index]);
      }
    }
    return searcheMatchedUsers;
  }

  String idEmailMeterNo(String a, String b, String c) {
    String s = "Id: $a    Email: $b    Meter No: $c";
    return s;
  }
// Future<List<User>> getAllNotAssignedUsers() async{
//  var allUsers = getAllUsers();
//  var allHouses = getAllHouses();
//  List<User> availableUsers = [];
//  for(int index = 0; index<allUsers)
// }