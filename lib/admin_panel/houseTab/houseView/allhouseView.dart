import 'dart:async';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_info/adminPreferences.dart';
import 'package:e_bill/admin_panel/houseTab/houseView/addHouse.dart';
import 'package:e_bill/admin_panel/houseTab/houseView/updateHouse.dart';
import 'package:e_bill/admin_panel/houseTab/house_model/house.dart';
import 'package:e_bill/admin_panel/houseTab/house_model/houseCRUDs.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';

class AllHouseView extends StatefulWidget {
  const AllHouseView({super.key});

  @override
  State<AllHouseView> createState() => _AllHouseViewState();
}

class _AllHouseViewState extends State<AllHouseView> {

  final StreamController _allHouseStreamController = StreamController.broadcast();
  List<House>allHouses=[];
  final String _createHouseBtn = "create-a-house";
  final String _updateHouseBtn = "update-a-house";
 @override
  void initState() {
    // TODO: implement initState
   Timer.periodic(const Duration(seconds: 2), (timer) {
       getAllHouses();
       //currentAdmin = getCurrentAdmin();
     });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //_allHouseStreamController.close();
    super.dispose();
  }


  Future getAllHouses() async{
    allHouses = await HouseStorage().fetchAllHouses();
    _allHouseStreamController.sink.add(allHouses);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      floatingActionButton: Hero(
        tag: _createHouseBtn,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green.shade200,
          ),
          // width: size.width * 0.2,
          // height: size.height * 0.08,
          child: IconButton(
            icon: const Icon(Icons.add_home_work_rounded),
            iconSize: 50,
            color: Colors.green,
            onPressed: (){ 
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,b,e){
                return const AddHouse();
              })
              );
            },
          ),
        ),
      ),
      body: Container(
        decoration:  const BoxDecoration(
            color: Colors.black87
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: StreamBuilder(
            stream: _allHouseStreamController.stream,
            builder: (context,snapshot){
              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child:  CircularProgressIndicator(),);
                case ConnectionState.active:
                  if(snapshot.hasData) {
                    final allHouses = snapshot.data as List<House>;
                    if(allHouses.isEmpty){
                      return const Center(child: Text("No houses yet!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),));

                    }
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 170,
                          childAspectRatio: 4/3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: allHouses.length,
                        itemBuilder:(_,index){
                          House thisHouse = allHouses[index];
                          var building = thisHouse.buildingName;
                          var houseNo = thisHouse.houseNo;
                          var assignedUserID = thisHouse.assignedUserID;
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext context,b,e){
                        return  UpdateHouse(thisHouse: thisHouse,);
                      }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: (assignedUserID=="")?Colors.grey : Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text("Building : $building",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                      Text("House No : $houseNo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
                  else{
                    return const Center(child:  Text("No houses yet!!"),);
                  }
                default:
                  return const Center(child:  CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }
}
