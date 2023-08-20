import 'dart:async';

import 'package:e_bill/admin_panel/usersTab/data_layer/user.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/userCRUDs.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/add_user.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/update_user.dart';

import 'package:flutter/material.dart';




class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> allUserData = []; 

  String searchText = "";

  StreamController _allUserStreamController = StreamController();

  final TextEditingController _searchBoxTextEditingController = TextEditingController();

  late Timer _timer;

  Future<void> getUserRecord() async {
    allUserData = await UserStorage().fetchAllUsers();
     List<User> filteredRecord= [];
      allUserData.forEach((user) {
      if( user.fullName.toString().toLowerCase().contains(searchText.toLowerCase())){
        filteredRecord.add(user);
      }
     });
    _allUserStreamController.sink.add(filteredRecord);
  }


  String idEmailMeterNo(String a, String b, String c) {
    String s = "Id: $a    Email: $b    Meter No: $c";
    return s;
  }

int cnt =1;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      print("hi$cnt");
      cnt++;     
       getUserRecord();     
       //currentAdmin = getCurrentAdmin();
     });
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    _allUserStreamController;
    if(_timer.isActive) _timer.cancel();
    _searchBoxTextEditingController.dispose();
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
                  color: Colors.blueGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchBoxTextEditingController,
                    decoration: const InputDecoration(
                      hintText: " Search...",
                      hintStyle:
                          TextStyle(color: Colors.white70,fontSize: 20),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (text) {
                      searchText = text;
                      getUserRecord();
                    },
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
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(userData.fullName,style: const TextStyle(color: Colors.grey, fontSize: 28),),
                                  subtitle: Text(
                                    idEmailMeterNo(userData.id, userData.email, userData.assignedMeterNo),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateUser(userInfo: userData,)));
                                  },
                                ),
                                const Divider(color: Colors.black,thickness: 6,),
                              ],
                            );
                          });
                    }
                    else{
                      return const Center(child: Text("No users!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),));
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
