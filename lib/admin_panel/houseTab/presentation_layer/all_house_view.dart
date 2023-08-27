import 'dart:async';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_info/adminPreferences.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/add_house_view.dart';
import 'package:e_bill/admin_panel/houseTab/presentation_layer/update_house.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/new_month_record/presentation_layer/new_month_record_view.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllHouseView extends StatefulWidget {
  const AllHouseView({super.key});

  @override
  State<AllHouseView> createState() => _AllHouseViewState();
}

class _AllHouseViewState extends State<AllHouseView> {

  String searchText = "";

  final StreamController _allHouseStreamController =
      StreamController.broadcast();

  final TextEditingController _searchBoxTextEditingController =
      TextEditingController();

  List<House> allHouses = [];
  final String _createHouseBtn = "create-a-house";
  final String _updateHouseBtn = "update-a-house";
  final String _workBtn = "lets-work";

  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getAllHouses();
      //currentAdmin = getCurrentAdmin();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer.isActive) _timer.cancel();
    _searchBoxTextEditingController.dispose();
    super.dispose();
  }

  Future getAllHouses() async {
    allHouses = await HouseStorage().fetchAllHouses();
    List<House>filteredRecord = [];
    allHouses.forEach((house) { 
      if(house.buildingName.toString().toLowerCase().contains(searchText)){
        filteredRecord.add(house);
      }
    });
    _allHouseStreamController.sink.add(filteredRecord);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: _workBtn,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context, b, e) {
                          return const NewMonthRecord();
                        }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange.shade200,
                    border: Border.all(width: 4,color: Colors.white)
                  ),
                  // width: size.width * 0.2,
                  // height: size.height * 0.08,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset("images/thunder.png",color: Colors.orange,)),
                ),
              ),
            ),
          ),
  
          Hero(
            tag: _createHouseBtn,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade200,
                border: Border.all(width: 4,color: Colors.white)
              ),
              // width: size.width * 0.2,
              // height: size.height * 0.08,
              child: IconButton(
                icon: const Icon(Icons.add_home_work_rounded),
                iconSize: 50,
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      transitionDuration: const Duration(milliseconds: 500),
                      reverseTransitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (BuildContext context, b, e) {
                        return const AddHouse();
                      }));
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchBoxTextEditingController,
                    decoration: const InputDecoration(
                      hintText: " Search by building name...",
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (text) {
                      searchText =text;
                      getAllHouses();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                  stream: _allHouseStreamController.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allHouses = snapshot.data as List<House>;
                          if (allHouses.isEmpty) {
                            return const Center(
                                child: Text(
                              "No house!!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.grey),
                            ));
                          }
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 170,
                                childAspectRatio: 4 / 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: allHouses.length,
                              itemBuilder: (_, index) {
                                House thisHouse = allHouses[index];
                                var building = thisHouse.buildingName;
                                var houseNo = thisHouse.houseNo;
                                var assignedUserID = thisHouse.assignedUserID;
                                return SingleChildScrollView(
                                  
                                  child: InkWell(
                                    onTap: () {
                                     
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: (assignedUserID == "")
                                                  ? Colors.grey
                                                  : Colors.green,
                                            ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Building : $building",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    "House No : $houseNo",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
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
                                                return UpdateHouse(
                                                  thisHouse: thisHouse,
                                                );
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
                                                  onTap: ()async{
                                                    var res = await HouseStorage().deleteHouse(house: thisHouse);
                                                    if(res){
                                                      Fluttertoast.showToast(msg: "Success! House deleted.");
                                                    }
                                                    else{
                                                      Fluttertoast.showToast(msg: "Failed! Could not delete the house.");
                                                    }
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text("No house!!"),
                          );
                        }
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
