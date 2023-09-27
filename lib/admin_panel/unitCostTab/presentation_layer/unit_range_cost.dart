import 'dart:async';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/update_unit_range_cost.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/update_vat_and_demand.dart';

import 'package:flutter/material.dart';

class UnitRangeCost extends StatefulWidget {
  const UnitRangeCost({super.key});

  @override
  State<UnitRangeCost> createState() => _UnitRangeCostState();
}

class _UnitRangeCostState extends State<UnitRangeCost> {
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
  late Timer _timer ;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // print("hi$cnt");
      // cnt++;
      getUnitCostRecord();
      getVatAndDemandCharge();
      //currentAdmin = getCurrentAdmin();
    });
    super.initState();
  }

  @override
  void dispose() {
    _unitCostStreamController;
    if(_timer.isActive)_timer.cancel();
    super.dispose();
  }

  vatAndDemandChargeView(Size size) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 245, 214),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: const Center(
              child: Text(
            "Vat And Demand Charge",
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.2,
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
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width.toInt() ~/ 300,
                          childAspectRatio:
                              1.5, // Aspect ratio makes the cards square
                        ),
                        children: [
                          Card(
                            color: const Color.fromARGB(255, 195, 243, 205),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Vat(%)",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${vatAndDemandData[0].vatPercentageTk.toString()}%",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: const Color.fromARGB(255, 195, 243, 205),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Demand Charge",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${vatAndDemandData[0].demandChargeTk.toString()} tk",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
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
                  color: Color.fromARGB(255, 214, 245, 214),
                  border: Border.all(color: Colors.green)),
              child: Scaffold(
                backgroundColor: Color.fromARGB(255, 214, 245, 214),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: AppBar(
                    title: const Center(
                        child: Text(
                      "Unit Ranges And Rates",
                      style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Colors.green,
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
                                allUnitCostData =
                                    snapshot.data as List<UnitCost>;
                                if (allUnitCostData.isEmpty) {
                                  return const Center(
                                      child: Text(
                                    "No users yet!!",
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
                                    childAspectRatio:
                                        1.5, // Aspect ratio makes the cards square
                                  ),
                                  itemCount: allUnitCostData.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: const Color.fromARGB(
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
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
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
                height: size.height * 0.3,
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
}
