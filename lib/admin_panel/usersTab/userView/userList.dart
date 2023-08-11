import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/userView/add_user.dart';
import 'package:e_bill/admin_panel/usersTab/userView/update_user.dart';
import 'package:e_bill/admin_panel/usersTab/user_model/user.dart';
import 'package:e_bill/admin_panel/usersTab/user_model/userCRUDs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_bill/api_connection/api_connection.dart';



class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> allUserData = [];
  final StreamController _allUserStreamController = StreamController.broadcast();
  Future<void> getRecord() async {
    allUserData = await UserStorage().fetchAllUsers();
    _allUserStreamController.sink.add(allUserData);
  }

  String idEmailMeterNo(String a, String b, String c) {
    String s = "Id: $a    Email: $b    Meter No: $c";
    return s;
  }


  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
       getRecord();
       //currentAdmin = getCurrentAdmin();
     });
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    //_allUserStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 2, 31, 46),
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Search...",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 97, 69, 69)),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _allUserStreamController.stream,
                builder:(context,snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator(),);
                  case ConnectionState.active:
                    if(snapshot.hasData){
                      allUserData = snapshot.data as List<User>;
                      if(allUserData.isEmpty){
                      return const Center(child: Text("No users yet!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),));
                      }
                      return ListView.builder(
                          itemCount: allUserData.length,
                          itemBuilder: (context, index) {
                            final userData = allUserData[index];
                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(userData.fullName,style: TextStyle(color: Colors.black, fontSize: 28),),
                                subtitle: Text(
                                  idEmailMeterNo(userData.id, userData.email, userData.assignedMeterNo),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateUser(userInfo: userData,)));
                                },
                              ),
                            );
                          });
                    }
                    else{
                      return const Center(child: Text("No users yet!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),));
                    }
                  default: return const Center(child: CircularProgressIndicator(),);
                    }
                }
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green.shade200,
          foregroundColor:  const Color.fromARGB(255, 21, 70, 23),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            const AddUser()
            ));
          },
          icon: const Icon(Icons.add, size: 28,),
          label: const Text('Add User',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        ),
      ),
    );
  }
}
