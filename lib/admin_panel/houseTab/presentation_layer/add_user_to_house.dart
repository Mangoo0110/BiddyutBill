import 'dart:async';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_constants.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/domain_layer/helper.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/get_specific_type_users.dart';
import 'package:flutter/material.dart';
typedef SelectedUserCallBack = void Function(String userId);
class AddUserToHouse extends StatefulWidget {
  SelectedUserCallBack userSelected;
  String assignedUserId ;
  AddUserToHouse({super.key,required this.userSelected,required this.assignedUserId});

  @override
  State<AddUserToHouse> createState() => _AddUserToHouseState();
}

class _AddUserToHouseState extends State<AddUserToHouse> {
  final TextEditingController _userIdInputController = TextEditingController();
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
  bool typeAll = true;
  String searchText = "";
  int userCount = 0;
  var userIdInputFormKey = GlobalKey<FormState>();

  late List<User> allUsers = [];
  late List<House> allHouses = [];
  StreamController searchedUserStreamController = StreamController();
  //late Timer _timer;
  
  
@override
  void initState() {
    // TODO: implement initState
    
     Future.delayed(const Duration(seconds: 1),() async{
      var users = await getSearchedUserExceptUser(searchedText: searchText,typeAll: true,userId: widget.assignedUserId);
      userCount = users.length;
      searchedUserStreamController .sink.add(users); 
    });

    
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
                var users = await getSearchedUserExceptUser(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS, typeAll: typeAll,userId: widget.assignedUserId);
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
                         Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                      child: Text("$userCount Users",style: TextStyle(color: Colors.black,fontSize: 12),),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Future.delayed(const Duration(seconds: 1),() async{
                                        var users = await getSearchedUserExceptUser(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS, typeAll: typeAll,userId: widget.assignedUserId);
                                        userCount = users.length;
                                        searchedUserStreamController.sink.add(users); 
                                      }); 
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                                        child:  Row(
                                          children: [
                                            Icon(Icons.replay_outlined),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding:  EdgeInsets.all(2.0),
                                          child: Text("User Type :",style: TextStyle(color: Colors.black,fontSize: 12),),
                                        ),
                                        Row(
                                          
                                          children: [
                                            Padding(
                                              padding:  const EdgeInsets.all(2.0),
                                              child: Text("All",style: TextStyle(color: (typeA==true)?Colors.black: Colors.black54,fontSize: 12),),
                                            ),
                                            Checkbox(
                                              value: typeAll,
                                              onChanged: (val){
                                                setState(() {
                                                  typeAll = true;
                                                  typeA = false;
                                                  typeS = false;
                                                  typeB = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSearchedUserExceptUser(searchedText: searchText,typeAll: true,userId: widget.assignedUserId);
                                                  userCount = users.length;
                                                  searchedUserStreamController.sink.add(users); 
                                                }); 
                                                });
                                              }
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              Text("A",style: TextStyle(color: (typeA==true)?Colors.black: Colors.black54,fontSize: 12),),
                                              Checkbox(
                                                value: typeA,
                                                onChanged: (val){
                                                  setState(() {
                                                    typeA = true;
                                                    typeAll = false;
                                                    typeS = false;
                                                    typeB = false;
                                                    Future.delayed(const Duration(seconds: 1),() async{
                                                    var users = await getSearchedUserExceptUser(searchedText: searchText,typeA: true,userId: widget.assignedUserId);
                                                    userCount = users.length;
                                                    searchedUserStreamController.sink.add(users); 
                                                  });  
                                                  });
                                                }
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                                Text("B",style: TextStyle(color: (typeB==true)?Colors.black: Colors.black54,fontSize: 12),),
                                              Checkbox(
                                                value: typeB,
                                              onChanged: (val){
                                                
                                                setState(() {
                                                  typeB = true;
                                                  typeAll = false;
                                                  typeA = false;
                                                  typeS = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSearchedUserExceptUser(searchedText: searchText,typeB: true, userId: widget.assignedUserId);
                                                  userCount = users.length;
                                                searchedUserStreamController.sink.add(users); 
                                                }); 
                                                });
                                              }
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                                Text("S",style: TextStyle(color: (typeS==true)?Colors.black: Colors.black54,fontSize: 12),),
                                              Checkbox(
                                                value: typeS,
                                              onChanged: (val){
                                                
                                                setState(() {
                                                  typeS = true;
                                                  typeAll = false;
                                                  typeA = false;
                                                  typeB = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSearchedUserExceptUser(searchedText: searchText,typeS: true, userId: widget.assignedUserId);
                                                  userCount = users.length;
                                                  searchedUserStreamController.sink.add(users); 
                                                }); 
                                                });
                                              }
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                         allUserData.isEmpty?const Center(child: Text("No users yet!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),))
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
                                                "Varsity ID : ${userData.varsityId}",
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
                                          widget.assignedUserId =userData.varsityId;
                                          widget.userSelected(userData.varsityId);
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