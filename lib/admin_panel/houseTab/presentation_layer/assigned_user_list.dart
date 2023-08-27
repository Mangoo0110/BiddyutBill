import 'dart:async';
import 'dart:math';

import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:flutter/material.dart';

typedef RemoveUserCallBack = void Function();
class AssignedUserList extends StatefulWidget {
  String assignedUserID;
  RemoveUserCallBack onRemove ;
  AssignedUserList({super.key,required this.assignedUserID, required this.onRemove});

  @override
  State<AssignedUserList> createState() => _AssignedUserListState();
}

class _AssignedUserListState extends State<AssignedUserList> {

  StreamController assignedUserStreamController = StreamController();

  streamAssignedUsers()async{

    print("varsity id: ${widget.assignedUserID}");
    var user = await UserStorage().fetchOneUser(varsityId: widget.assignedUserID); 
    //print("User is ${users[0].fullName}");
    List<User> users = [];
    if(user!=null)users.add(user);
    assignedUserStreamController.sink.add(users);
  }
  @override
  void initState() {
    // TODO: implement initState
    streamAssignedUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     streamAssignedUsers();
     Size size = MediaQuery.of(context).size;
    return 
         Container(
      alignment: Alignment.topLeft,
      height: 150,
      width:  280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6)
      ),
      child: StreamBuilder(
        stream: assignedUserStreamController.stream,
        builder:(context, snapshot){
          if(snapshot.hasError){
            print("error");
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4)
              ),
              width: 280,
              child:  Center(child: Text("Error: ${snapshot.error.toString()}",style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),));
            //Text("Error: ${snapshot.error.toString()}",style: const TextStyle(color: Colors.white),);
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            print("loading");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                width: 280,
                child: const SingleChildScrollView( scrollDirection: Axis.horizontal,child: Center(child: Text("Loading...",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),))),
            );
          }
          else if(snapshot.hasData){
            var users = snapshot.data as List<User>;
            if(users.isEmpty){
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(6)
                ),
                width: 280,
                child: const Center(child: Text("No user yet!!",style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),)),
            );
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context,index){
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 280,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white
                          ),
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(alignment: Alignment.topLeft,child: Text("Name : ${users[index].fullName}",style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                                Container(alignment: Alignment.topLeft,child: Text("Occupation : ${users[index].occupation}",style: const TextStyle(color: Colors.black),)),
                                Container(alignment: Alignment.topLeft,child: Text("Account No : ${users[index].accountNo}",style: const TextStyle(color: Colors.black),)),
                                Container(alignment: Alignment.topLeft,child: Text("Varsity Id : ${users[index].varsityId}",style: const TextStyle(color: Colors.black),)),
                                          
                              ],
                            ),
                          ),
                          
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: InkWell(
                              onTap: () async{
                                widget.assignedUserID = '';
                                print("now");
                                print(widget.assignedUserID);
                                widget.onRemove();
                                setState(() {
                                  streamAssignedUsers();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width:  280,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(3),
                                  //border: Border.all(color: Colors.black)
                                ),
                                child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text("Remove User",style: TextStyle(color: Colors.redAccent.shade200,fontSize: 17,fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else{
            print("issues??");
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              width: 280,
              child: const Center(child: Text("Facing some issues!!",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),),));
             //const Text("Facing some issues!!",style: TextStyle(color: Colors.white),);
          }
        },
      ),
    );

  }
}


