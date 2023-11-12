import 'dart:async';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_constants.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/domain_layer/helper.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/get_specific_type_users.dart';
import 'package:flutter/material.dart';
typedef SelectedUserCallBack = void Function(User userId);
class AddOrRemoveHouseUser extends StatefulWidget {
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
  SelectedUserCallBack userSelected;
  String assignedUserId ;
  AddOrRemoveHouseUser({super.key,required this.userSelected,required this.assignedUserId,required this.typeA, required this.typeB, required this.typeS});

  @override
  State<AddOrRemoveHouseUser> createState() => _AddOrRemoveHouseUserState();
}

class _AddOrRemoveHouseUserState extends State<AddOrRemoveHouseUser> {
  final TextEditingController _userIdInputController = TextEditingController();
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
  String searchText = "";
  int userCount = 0;
  var userIdInputFormKey = GlobalKey<FormState>();

  late List<User> allUsers = [];
  late List<House> allHouses = [];
  StreamController searchedUserStreamController = StreamController();
  //late Timer _timer;
  getRelaventUsers()async{
    typeA = widget.typeA;
    typeB = widget.typeB;
    typeS = widget.typeS;
    
    var users = await getSearchedUserExceptUser(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS,userId: widget.assignedUserId);
    userCount = users.length;
    searchedUserStreamController .sink.add(users); 
  
  }
  
@override
  void initState() {
    // TODO: implement initState
    

    
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //if(_timer.isActive) _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    getRelaventUsers();
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userIdInputController,
              key: userIdInputFormKey,
              decoration: const InputDecoration(
                hintText: "Start typing user user's name...",
                hintStyle: TextStyle(color: Colors.grey)
              ),
              onChanged: (searchText) {
                Future.delayed(const Duration(seconds: 1),() async{
                var users = await getSearchedUserExceptUser(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS,userId: widget.assignedUserId);
                userCount = users.length;
                searchedUserStreamController.sink.add(users); 
              }); 
              },
            ),
          ),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              //color:  Colors.black54,
              borderRadius: BorderRadius.circular(5)
            ),
            child: StreamBuilder(
              stream: searchedUserStreamController.stream,
              builder:(context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(),);
                case ConnectionState.active:
                  if(snapshot.hasData){
                    var allUserData = snapshot.data as List<User>;

                    return Column(
                      children: [
                        allUserData.isEmpty?
                          const Expanded(
                                  child: Center(
                                            child: Text("No users yet!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),
                                            )))
                        :
                          Expanded(
                            child: ListView.builder(
                                itemCount: allUserData.length,
                                itemBuilder: (context, index) {
                                  final userData = allUserData[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          trailing: const Text("Available",style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.bold),),
                                          title: Text(userData.fullName,style: const TextStyle(color: Colors.black, fontSize: 28),),
                                          subtitle: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Varsity ID : ${userData.id}",
                                                  style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Email : ${userData.emailAdress}",
                                                  style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Occupation : ${userData.occupation}",
                                                  style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            widget.assignedUserId = userData.id;
                                            widget.userSelected(userData);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        
                      ],
                    );
                  }
                  else{
                    return const Center(child: Text("No users!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),));
                  }
                default: return const Center(child: CircularProgressIndicator(),);
                  }
              }
            ),
          )
        ],
      ),
    )
    ;
  }
}