import 'dart:async';
import 'dart:math';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/check_if_all_good_for_new_range.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/update_unit_range_cost.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/update_vat_and_demand.dart';
import 'package:e_bill/common_logic/check_valid_double.dart';

import 'package:flutter/material.dart';

class UnitRangeCost extends StatefulWidget {
  const UnitRangeCost({super.key});

  @override
  State<UnitRangeCost> createState() => _UnitRangeCostState();
}

class _UnitRangeCostState extends State<UnitRangeCost> {
  bool addNewRange = false;
  bool allGood = false;
  TextEditingController fromNewRange = TextEditingController();
  TextEditingController toNewRange = TextEditingController();
  TextEditingController costNewRange = TextEditingController();
  late UnitCost newUnitCostRange ;
  double fromRange = 0;
  double toRange = 0;
  double costOfRange = 0;
  List<UnitCost> allUnitCostData = [];
  List<DemandChargeVatPercentage> vatAndDemandData = [];
  final StreamController _unitCostStreamController = StreamController();
  final StreamController _vatAndDemandStreamController = StreamController();
  Future<void> getUnitCostRecord() async {
    allUnitCostData = await UnitCostStorage().fetchAllUnitCost();

    _unitCostStreamController.sink.add(allUnitCostData);
  }

  Future<void> getVatAndDemandCharge() async {
    vatAndDemandData = await DemandChargeVatPercentageStorage()
        .fetchDemandChargeVatPercentageStorage();
    _vatAndDemandStreamController.sink.add(vatAndDemandData);
  }
  void startFetching() async{
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async{
      // print("hi$cnt");
      // cnt++;
      await getUnitCostRecord();
      await getVatAndDemandCharge();
    //   if(allUnitCostData.isNotEmpty && vatAndDemandData.isNotEmpty){
    //   if(_timer.isActive){
    //     _timer.cancel();
    //   }
    // }
      //currentAdmin = getCurrentAdmin();
    });
  }
  late Timer _timer ;
  @override
  void initState() {
    fromNewRange.text = "-100";
    toNewRange.text = "-56";
    costNewRange.text = "0";
    newUnitCostRange = UnitCost(startingRange: -100, endingRange: -56, rate: 0);
    startFetching();
    super.initState();
  }

  @override
  void dispose() {
    _unitCostStreamController;
    if(_timer.isActive)_timer.cancel();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    startFetching();
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 239, 255, 239),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 214, 245, 214),
                  border: Border.all(color: Colors.green)),
              child: Scaffold(
                backgroundColor: const Color.fromARGB(255, 214, 245, 214),
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: AppBar(
                    title: const Center(
                        child: Text(
                          "Unit Ranges And Rates",
                          style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Colors.green,
                    actions: [
                      (addNewRange)?
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async{
                              if(allGood){
                                var result = await UnitCostStorage().addNewUnitCostRange(newUnitCost: newUnitCostRange);
                                addNewRange = false;
                                allGood = false;
                                if(result == true){
                                  setState(() {
                                  });
                                }
                              }
                              else{
                                setState(() {
                                  allGood = checkIfAllGood(allUnitCost: allUnitCostData, newUnitCostRange: newUnitCostRange);
                                });
                              }
                            },
                            child: (allGood)?
                             const Text("Save", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)
                             :
                             const Text("Check", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          TextButton(
                            onPressed: (){
                              setState(() {
                                addNewRange = false;
                              });
                            },
                            child: const Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          )
                        ],
                      )
                      :
                      const Text("")
                    ]
                  ),
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: StreamBuilder(
                        stream: _unitCostStreamController.stream,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.active:
                              if (snapshot.hasData) {
                                if(_timer.isActive){
                                  _timer.cancel();
                                }
                                allUnitCostData =
                                    snapshot.data as List<UnitCost>;
                                if (allUnitCostData.isEmpty) {
                                  return const Center(
                                      child: Text(
                                    "No data yet!!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.grey),
                                  ));
                                }
                                
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: size.width.toInt() ~/ 300,
                                        childAspectRatio: 1.5, // Aspect ratio makes the cards square
                                      ),
                                  itemCount: allUnitCostData.length +1,
                                  itemBuilder: (context, index) {
                                     return (index == allUnitCostData.length)?
                                            (!addNewRange)?
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                  addNewRange = true;
                                                  });
                                                },
                                                child: Card(
                                                  color: const Color.fromARGB(
                                                      255, 195, 243, 205),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: const Center(
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Icon(Icons.add_circle_rounded, color: Colors.black38,),
                                                          Text("Add a new range", style: TextStyle(color: Colors.black38, fontSize: 18), maxLines: 2,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              :
                                              Card(
                                                color: (newUnitCostRange.startingRange >= newUnitCostRange.endingRange) ? Colors.red.shade200 : const Color.fromARGB(
                                                    255, 195, 243, 205),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:  const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text("From :", style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                                                          Expanded(
                                                            flex: 2,
                                                            child: TextField(
                                                              controller:  fromNewRange,
                                                              onChanged: (value) {
                                                                if(value == ""){
                                                                  fromNewRange.text = "0";
                                                                }
                                                                setState(() {
                                                                  if(isValidDoubleText(text: value)){
                                                                    newUnitCostRange.startingRange = double.parse(value);
                                                                  }
                                                                  else {
                                                                    fromNewRange.text = newUnitCostRange.startingRange.toString();
                                                                  }
                                                                
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text("To :", style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                                                          Expanded(
                                                            flex: 2,
                                                            child: TextField(
                                                              controller: toNewRange,
                                                              onChanged: (value) {
                                                                if(value == ""){
                                                                  toNewRange.text = "0";
                                                                }
                                                                setState(() {
                                                                  if(isValidDoubleText(text: value)){
                                                                    newUnitCostRange.endingRange = double.parse(value);
                                                                  }
                                                                  else {
                                                                    toNewRange.text = newUnitCostRange.endingRange.toString();
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Expanded(
                                                            flex: 1,
                                                            child: Text("Cost :", style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                                                          Expanded(
                                                            flex: 2,
                                                            child: TextField(
                                                              controller: costNewRange,
                                                              onChanged: (value) {
                                                                if(value == ""){
                                                                  costNewRange.text = "0";
                                                                }
                                                                setState(() {
                                                                  if(isValidDoubleText(text: value)){
                                                                    newUnitCostRange.rate = double.parse(value);
                                                                  }
                                                                  else {
                                                                    costNewRange.text = newUnitCostRange.rate.toString();
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                           :
                                           Card(
                                                color: (addNewRange && !(allUnitCostData[index].startingRange > newUnitCostRange.endingRange || allUnitCostData[index].endingRange < newUnitCostRange.startingRange))? Colors.red.shade200 : const Color.fromARGB(
                                                    255, 195, 243, 205),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${allUnitCostData[index].startingRange} - ${allUnitCostData[index].endingRange} Unit",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 25,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "${allUnitCostData[index].rate} tk/unit",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          var res = Future.delayed(const Duration(seconds: 1), () async{
                                                            return await UnitCostStorage().deleteUnitRangeCost(unitRangeCost: allUnitCostData[index]);
                                                          });
                                                          if(res == true){
                                                            setState(() {
                                                              //startFetching();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Colors.red.shade200,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets.symmetric(
                                                              vertical: 4,
                                                              horizontal: 15
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 18
                                                                  ),
                                                                ),
                                                                Icon(Icons.delete, color: Colors.red, size: 20,)
                                                              ],
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
                              else {
                                return const Center(
                                    child: Text(
                                  "No Unit rate inserted!!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.grey),
                                ));
                              }
                            default:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        }),
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: Colors.green.shade200,
                  foregroundColor: const Color.fromARGB(255, 21, 70, 23),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return UpdateUnitCost(
                              allUnitCostData: allUnitCostData);
                        },
                      ),
                    );
                  },
                  label: const Text(
                    'Update Unit Rates',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 245, 214),
                  //borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green,
                  ),
                ),
                child: vatAndDemandChargeView(size))
          ],
        ),
      ),
    );
  }
   vatAndDemandChargeView(Size size) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 245, 214),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const Center(
              child: Text(
                "Vat And Demand Charge",
                style: TextStyle(color: Colors.white),
              )
          ),
          backgroundColor: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.4,
          width: size.width,
          child: StreamBuilder(
              stream: _vatAndDemandStreamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      vatAndDemandData =
                          snapshot.data as List<DemandChargeVatPercentage>;
                      if (vatAndDemandData.isEmpty) {
                        return const Center(
                                child: Text(
                                  "No Vat and Demand Charge addded",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.grey),
                                ));
                      }
                      //if(_timer.isActive)_timer.cancel();
                      return GridView.builder(
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: size.width.toInt() ~/ 400,
                                        childAspectRatio: 1.5, // Aspect ratio makes the cards square
                                      ),
                        itemCount: vatAndDemandData.length,
                        itemBuilder:(context,index)=> 
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  typeInfo(vatAndDemandData[index]),
                                  Expanded(
                                    child: Card(
                                      color: const Color.fromARGB(255, 195, 243, 205),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Vat : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "${vatAndDemandData[index].vatPercentageTk.toString()}%",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Demand Charge : ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 23,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    Text(
                                                      "${vatAndDemandData[index].demandChargeTk.toString()} tk",
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        
                      );
                    }
                    else {
                      return const Center(
                          child: Text(
                        "No Vat and demand Charge added",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.grey),
                      ));
                    }
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade200,
        foregroundColor: const Color.fromARGB(255, 21, 70, 23),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return UpdateVatAndDemand(vatAndDemandData: vatAndDemandData);
              },
            ),
          );
        },
        label: const Text(
          'Update Vat and Demand Charge',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }
  Widget typeInfo(DemandChargeVatPercentage demandVat){
    String type = "a";
    if(demandVat.typeB == true) type = "b";
    if(demandVat.typeS == true) type = "s";
    return Text("Type $type", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),);
  }
}
