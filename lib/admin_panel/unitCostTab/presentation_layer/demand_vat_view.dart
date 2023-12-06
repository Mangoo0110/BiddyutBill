import 'dart:async';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/update_vat_and_demand.dart';
import 'package:flutter/material.dart';

class DemandAndVatView extends StatefulWidget {
  const DemandAndVatView({super.key});

  @override
  State<DemandAndVatView> createState() => _DemandAndVatViewState();
}

class _DemandAndVatViewState extends State<DemandAndVatView> {
  final StreamController _vatAndDemandStreamController = StreamController();
  List<DemandChargeVatPercentage> vatAndDemandData = [];
  late Timer _timer ;

  Future<void> getVatAndDemandCharge() async {
    vatAndDemandData = await DemandChargeVatPercentageStorage()
        .fetchDemandChargeVatPercentageStorage();
    _vatAndDemandStreamController.sink.add(vatAndDemandData);
  }
  void startFetching() async{
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async{
      await getVatAndDemandCharge();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    startFetching();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer.isActive){
      _timer.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context,constraints) => Scaffold(
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
            height: constraints.maxHeight,
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
                                          crossAxisCount: constraints.maxWidth.toInt() ~/ 400,
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
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder: (BuildContext context, _, __) {
                                                        return UpdateVatAndDemand(vatAndDemandData: vatAndDemandData[index]);
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: Colors.blue.shade200,
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 15
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                        Icon(Icons.edit, color: Colors.blue, size: 20,)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
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