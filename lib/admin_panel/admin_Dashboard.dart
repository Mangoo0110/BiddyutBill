import 'dart:async';
import 'dart:convert';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:e_bill/house_model/houseCRUDs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import '../house_model/house.dart';
import 'package:e_bill/admin_info/adminPreferences.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  //late final Admin currentAdmin;
  final PageController _pageController = PageController();
   int _index=0;
   final StreamController _allHouseStreamController = StreamController.broadcast();
   List<House>allHouses=[];

   @override
  void initState() {
    // TODO: implement initState
     Timer.periodic(const Duration(seconds: 1), (timer) {
       getAllHouses();
       //currentAdmin = getCurrentAdmin();
     });
     //_allHouseStreamController  = StreamController.broadcast();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _allHouseStreamController;
    super.dispose();
  }

  getCurrentAdmin() async{
     return await CurrrentAdmin.getCurrentAdmin();
  }

   Future getAllHouses() async{
     allHouses = await HouseStorage().fetchAllHouses();
     _allHouseStreamController.sink.add(allHouses);
   }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //String adminId = currentAdmin!.id;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child:  Text("C o n t r o l  P a n e l",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: const Column(
            children: [
              Text("Hello,",style: TextStyle(color: Colors.white),),
              Text("Admin",style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.green.shade300,
                width: 2
              ),
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.person,color: Colors.green,),
             onPressed: (){},
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: PageView.builder(
          itemCount: 4,
          controller: _pageController,
          onPageChanged: (page){
            setState(() {
              _index = page;
            });
          },
          itemBuilder: (context,page){
            print(page);
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.white70
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: chooseBot(context, page),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 1,
        ),
        child: Container(
          color: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GNav(
                gap: 30,
                backgroundColor: Colors.transparent,
                tabBackgroundColor: Colors.green.shade200,
                //padding: const EdgeInsets.all(19),
                tabBorderRadius: 28 ,
                selectedIndex: _index,
                textStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                tabs: const [
                    GButton(
                    icon: Icons.home_work,
                    text: "Houses",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  ),
                  GButton(
                    icon: Icons.monetization_on,
                    text: "Unit Cost",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),                  ),
                  GButton(
                    icon: Icons.person_add,
                    text: "Add User",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),                  ),
                  GButton(
                    icon: Icons.message_outlined,
                    text: "Complains",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),                  ),

                ],
                onTabChange: (index){
                  setState(() {
                    _index = index;

                  });
                  _pageController.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),

    );
  }
  Widget unitCost(BuildContext context){
  TextEditingController phase1 = TextEditingController();
  TextEditingController phase2 = TextEditingController();
  TextEditingController phase3 = TextEditingController();
  TextEditingController phase4 = TextEditingController();
  TextEditingController phase5 = TextEditingController();
  TextEditingController phase6 = TextEditingController();
  Size size = MediaQuery.of(context).size;
  final labelFontHeight = size.height * 0.06;
  final labelFontWidth = size.width * 0.05;
  final unitPricePhases = <String>{
    "Unit (0 - 50) ",
    "Unit (0 - 75) ",
    "Unit (76 - 100) ",
    "Unit (101 - 200) ",
    "Unit (201 - 300) ",
    "Unit (301 - 400) ",
    "Unit (401 - 600) ",
    "Unit (Above 600)"
  };

  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.black,

    child: ListView.builder(
      itemCount: unitPricePhases.length,
        itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 80,
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(unitPricePhases.elementAt(index),style: const TextStyle(fontWeight: FontWeight.bold),),
              trailing: const Text("0 Tk.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
              tileColor: Colors.orange.shade600,
              selectedTileColor: Colors.green,
            ),
          ),
        );
        }
    ),
  );
}

  Widget houseView(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      floatingActionButton: Container(
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
            Navigator.pushNamed(context, addHouseRoute);
          },
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
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: (assignedUserID=="")?Colors.grey : Colors.green,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text("Building : $building",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                    Text("House No : $houseNo",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
                  else{
                    return const Center(child:  CircularProgressIndicator(),);
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


  Widget addUser(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.shade300,
      ),
    );
  }
  Widget userComplains(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade300,
      ),
    );
  }
  Widget chooseBot(BuildContext context, int pageIndex){
    if(pageIndex==0)return houseView(context);
    if(pageIndex==1) return unitCost(context);
    if(pageIndex==2)return addUser(context);
    else return userComplains(context);

  }
}
