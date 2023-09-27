import 'dart:async';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/get_specific_type_users.dart';
import 'package:e_bill/admin_panel/usersTab/domain_layer/user_details_text.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/add_user.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/update_user.dart';
import 'package:e_bill/common_ui/confirm_dialog_box.dart';
import 'package:e_bill/common_ui/detail_dialog_box.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> allUserData = []; 
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
  bool typeAll = true;
  String searchText = "";
  int userCount = 0;
  StreamController _allUserStreamController = StreamController();

  final TextEditingController _searchBoxTextEditingController = TextEditingController();


  




  String idEmailMeterNo(String a, String b, String c) {
    String s = "Id: $a    Email: $b    Account No: $c";
    return s;
  }

int cnt =1;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),() async{
      var users = await getSpecificUsers(searchedText: searchText,typeAll: true);
      userCount = users.length;
      _allUserStreamController.sink.add(users); 
    });
     //_searchBoxTextEditingController.dispose();
     //_allUserStreamController.done;
    super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    _allUserStreamController;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          controller: _searchBoxTextEditingController,
                          decoration: const InputDecoration(
                            hintText: " Search by user name...",
                            hintStyle:
                                TextStyle(color: Colors.white70,fontSize: 20),
                            focusColor: Colors.white,
                            fillColor: Colors.white,
                          ),
                          //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (text) {
                            setState(() {
                            searchText = text;
                            Future.delayed(const Duration(seconds: 1),() async{
                            var users = await getSpecificUsers(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS, typeAll: typeAll);
                            userCount = users.length;
                            _allUserStreamController.sink.add(users); 
                          });
                            }); 
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    const AddUser()
                    ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                        child:  Row(
                          children: [
                            Icon(Icons.add, size: 28,),
                            Text('Add User',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
                      
                      return Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Text("$userCount Users",style: TextStyle(color: Colors.white60,fontSize: 17),),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Future.delayed(const Duration(seconds: 1),() async{
                                        var users = await getSpecificUsers(searchedText: searchText,typeA: typeA, typeB: typeB, typeS: typeS, typeAll: typeAll);
                                        userCount = users.length;
                                        _allUserStreamController.sink.add(users); 
                                      }); 
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade400,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
                                          child:  Row(
                                            children: [
                                              Icon(Icons.replay_outlined),
                                              Text("Reload",style: TextStyle(color: Colors.black, fontSize: 17),),
                                            ],
                                          ),
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
                                          padding:  EdgeInsets.all(8.0),
                                          child: Text("User Type :",style: TextStyle(color: Colors.white,fontSize: 20),),
                                        ),
                                        Row(
                                          
                                          children: [
                                            Padding(
                                              padding:  const EdgeInsets.all(8.0),
                                              child: Text("All",style: TextStyle(color: (typeA==true)?Colors.white: Colors.white60,fontSize: 20),),
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
                                                  var users = await getSpecificUsers(searchedText: searchText,typeAll: true);
                                                  userCount = users.length;
                                                  _allUserStreamController.sink.add(users); 
                                                }); 
                                                });
                                              }
                                            ),
                                          ],
                                        ),
                                        Row(
                                          
                                          children: [
                                            Padding(
                                              padding:  const EdgeInsets.all(8.0),
                                              child: Text("A",style: TextStyle(color: (typeA==true)?Colors.white: Colors.white60,fontSize: 20),),
                                            ),
                                            Checkbox(
                                              value: typeA,
                                              onChanged: (val){
                                                setState(() {
                                                  typeA = true;
                                                  typeAll = false;
                                                  typeS = false;
                                                  typeB = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSpecificUsers(searchedText: searchText,typeA: true);
                                                  userCount = users.length;
                                                  _allUserStreamController.sink.add(users); 
                                                });  
                                                });
                                              }
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("B",style: TextStyle(color: (typeB==true)?Colors.white: Colors.white60,fontSize: 20),),
                                              ),
                                              Checkbox(
                                                value: typeB,
                                              onChanged: (val){
                                                
                                                setState(() {
                                                  typeB = true;
                                                  typeAll = false;
                                                  typeA = false;
                                                  typeS = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSpecificUsers(searchedText: searchText,typeB: true);
                                                  userCount = users.length;
                                                  _allUserStreamController.sink.add(users); 
                                                }); 
                                                });
                                              }
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                                Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("S",style: TextStyle(color: (typeS==true)?Colors.white: Colors.white60,fontSize: 20),),
                                              ),
                                              Checkbox(
                                                value: typeS,
                                              onChanged: (val){
                                                
                                                setState(() {
                                                  typeS = true;
                                                  typeAll = false;
                                                  typeA = false;
                                                  typeB = false;
                                                  Future.delayed(const Duration(seconds: 1),() async{
                                                  var users = await getSpecificUsers(searchedText: searchText,typeS: true);
                                                  userCount = users.length;
                                                  _allUserStreamController.sink.add(users); 
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
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(userData.fullName,style: const TextStyle(color: Colors.grey, fontSize: 28),),
                                        subtitle: Text(
                                          idEmailMeterNo(userData.varsityId, userData.emailAdress, userData.accountNo),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).push(PageRouteBuilder(
                                                        opaque: false,
                                                        transitionDuration:
                                                        const Duration(milliseconds: 500),
                                                         reverseTransitionDuration:
                                                        const Duration(milliseconds: 200),
                                                        pageBuilder:
                                                        (BuildContext context, b, e) {
                                                      return DetailDialogBox(
                                                            titleText: "User Details",
                                                            bodyText: userDetailsText(user: userData),
                                                            onOk: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          );
                                                        }));
                          
                                          
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateUser(userInfo: userData,)));
                                        },
                                        trailing:  SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                    children: [
                                                      (userData.isEmailVerified=="true")
                                                      ?
                                                     const  Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child:  Row(
                                                          children: [
                                                            Icon(Icons.verified,color: Colors.green,),
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                              child: Text("Verified Email",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white54,fontSize: 20),),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                      :
                                                      const Padding(
                                                        padding:  EdgeInsets.all(8.0),
                                                        child:  Row(
                                                          children: [
                                                            Icon(Icons.error,color: Colors.yellow,),
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                              child: Text("Email Not Verified",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white54,fontSize: 20),),
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: InkWell(
                                                          onTap: (){
                                                          Navigator.of(context).push(PageRouteBuilder(
                                                          opaque: false,
                                                          transitionDuration:
                                                          const Duration(milliseconds: 500),
                                                           reverseTransitionDuration:
                                                          const Duration(milliseconds: 200),
                                                          pageBuilder:
                                                          (BuildContext context, b, e) {
                                                        return UpdateUser(userInfo: userData);
                                                          }));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white54,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: const Padding(
                                                              padding:  EdgeInsets.all(2.0),
                                                              child: Icon(Icons.edit,size: 27,color: Colors.black38,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: InkWell(
                                                          onTap: () async{
                                                          Navigator.of(context).push(PageRouteBuilder(
                                                          opaque: false,
                                                          transitionDuration:
                                                          const Duration(milliseconds: 500),
                                                           reverseTransitionDuration:
                                                          const Duration(milliseconds: 200),
                                                          pageBuilder:
                                                          (BuildContext context, b, e) {
                                                        return ConfirmDialogBox(titleText: "Delete User",
                                                            bodyText: "Are you sure to delete user [Name :${userData.fullName}, Varsity ID : ${userData.varsityId}]",
                                                             onConfirm:()async{
                                                              var res = await UserStorage().deleteUser(user: userData);
                                                           if(res){
                                                            Fluttertoast.showToast(msg: "Success!! User deleted.");
                                                           }
                                                           else{
                                                            Fluttertoast.showToast(msg: "Failed!! User could not be deleted.");
                                                           }
                                                           if(res){
                                                            Future.delayed(const Duration(milliseconds: 500),(){
                                                              Navigator.of(context).pop();
                                                            });
                                                           }
                                                             } ,
                                                             onCancel: (){
                                                              Navigator.of(context).pop();
                                                             }
                                                             );
                                                          }));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white54,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child:  const Padding(
                                                              padding: EdgeInsets.all(2.0),
                                                              child: Icon(Icons.delete_outline,size: 27,color: Colors.black38,),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                            
                                        ),
                                      const Divider(color: Colors.black,thickness: 6,),
                                    ],
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
            ),
          ],
        ),

      ),
    );
  }
}
