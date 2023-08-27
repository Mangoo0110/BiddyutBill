// ignore_for_file: no_logic_in_create_state
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';

class UpdateVatAndDemand extends StatefulWidget {
  const UpdateVatAndDemand({super.key, required this.vatAndDemandData});
  final List<DemandChargeVatPercentage> vatAndDemandData;
  @override
  State<UpdateVatAndDemand> createState() =>
      _UpdateVatAndDemandState(vatAndDemandData: vatAndDemandData);
}

class _UpdateVatAndDemandState extends State<UpdateVatAndDemand> {
  late List<DemandChargeVatPercentage> vatAndDemandData;
  _UpdateVatAndDemandState({required this.vatAndDemandData});

  TextEditingController vatTextEditingController = TextEditingController();

  TextEditingController demandChargeTextEditingController =
      TextEditingController();

  List<String> updatedVatAndDemandData = [];
  updateVatAndDemand() async {
    try {
      var res = await http.post(Uri.parse(API.updateDemandChargeVatPercentage),
          headers: {"Accept": "application/json"},
          body: jsonEncode(updatedVatAndDemandData));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          print("Updated Successfully");
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5, msg: "Updated Successfully");
        } else {
          Fluttertoast.showToast(msg: "Update failed");
          print("Updated failed");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void prevDataPushController() {
    vatTextEditingController.text =
        vatAndDemandData[0].vatPercentageTk.toString();
    demandChargeTextEditingController.text =
        vatAndDemandData[0].demandChargeTk.toString();
  }

  void updateData() {
    updatedVatAndDemandData.add(vatTextEditingController.text);
    updatedVatAndDemandData.add(demandChargeTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    prevDataPushController();
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color.fromARGB(255, 222, 250, 223),
        content: Container(
            width: (MediaQuery.of(context).size.width * 0.25) + 300,
            child: SingleChildScrollView(
                child: Column(
              children: [
                AppBar(
                  title: const Center(
                    child: Text(
                      "Update Demand Charge",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
                Container(
                  child: SingleChildScrollView(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded corners
                            ),
                            color: Color.fromARGB(255, 195, 243, 205),
                            elevation: 10,
                            child: ListTile(
                              leading: const Text("vat(%)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black)),
                              trailing: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: TextFormField(
                                    controller: vatTextEditingController,
                                    decoration: const InputDecoration(
                                      //hintText: vatAndDemandData[0].vat,
                                      labelStyle: TextStyle(color: Colors.white),
                                      focusColor: Colors.white,
                                      fillColor: Colors.white,
                                    ),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              tileColor: Colors.green.shade300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            color: Color.fromARGB(255, 195, 243, 205),
                            elevation: 10,
                            child: ListTile(
                              leading: const Text("Demand Charge(taka)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black)),
                              trailing: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: TextFormField(
                                    controller: demandChargeTextEditingController,
                                    decoration: const InputDecoration(
                                      // hintText: vatAndDemandData[0].demand,
                                      labelStyle: TextStyle(color: Colors.white),
                                      focusColor: Colors.white,
                                      fillColor: Colors.white,
                                    ),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              tileColor: Colors.green.shade300,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.green.shade200,
                  foregroundColor: const Color.fromARGB(255, 21, 70, 23),
                  onPressed: () {
                    updateData();
                    updateVatAndDemand();
                    Navigator.pop(context);
                  },
                  label: const Text(
                    'Confirm',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ],
            ))));
  }
}
