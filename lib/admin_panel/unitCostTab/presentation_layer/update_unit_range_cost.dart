// ignore_for_file: no_logic_in_create_state
import 'dart:convert';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateUnitCost extends StatefulWidget {
  const UpdateUnitCost({super.key, required this.allUnitCostData});
  final List<UnitCost> allUnitCostData;
  @override
  State<UpdateUnitCost> createState() =>
      _UpdateUnitCostState(allUnitCostDataNow: allUnitCostData);
}

class _UpdateUnitCostState extends State<UpdateUnitCost> {
  late List<UnitCost> allUnitCostDataNow;
  _UpdateUnitCostState({required this.allUnitCostDataNow});

  final Map<double, TextEditingController> _textControllers = new Map();
  void getControllers() {
    allUnitCostDataNow.forEach((data) =>
        _textControllers[data.endingRange] =
            TextEditingController());
  }

  var endingRangeAndRates = new Map();
  void merge() {
    for (int i = 0; i < allUnitCostDataNow.length; i++) {
      endingRangeAndRates[allUnitCostDataNow[i].endingRange.toString()] =
          _textControllers[allUnitCostDataNow[i].endingRange]?.text.trim();
    }
  }

  updateUnitRangeCost() async {
    try {
      // endingRangeAndRates.forEach((key, value) {
      //   print('Key = $key : Value = $value');
      // });
      var res = await http.post(Uri.parse(API.updateAllUnitCost),
          headers: {"Accept": "application/json"},
          body: jsonEncode(endingRangeAndRates));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["Success"] == true) {
          Fluttertoast.showToast(
              timeInSecForIosWeb: 5, msg: "Updated Successfully");
        } else {
          Fluttertoast.showToast(msg: "Update failed");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  prevDataPustToControllers() {
    for (int i = 0; i < allUnitCostDataNow.length; i++) {
      _textControllers[allUnitCostDataNow[i].endingRange]?.text =
          allUnitCostDataNow[i].rate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
  getControllers();
  prevDataPustToControllers();
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    backgroundColor: const Color.fromARGB(255, 222, 250, 223),
    content: Container( // Wrap the content in a Container
      width: (MediaQuery.of(context).size.width*0.25)+300, // Set a width
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Center(
                child: Text(
                  "Update Unit Rates",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: Colors.green,
              automaticallyImplyLeading: false,
            ),
            Container(
              //color: const Color.fromARGB(255, 213, 238, 214),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allUnitCostDataNow.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    // ... your existing ListTile code ...
                    child: Card(
                      elevation: 20,
                      child: ListTile(
                      leading: Text(
                        allUnitCostDataNow[index].startingRange.toString() +
                            " - " +
                            allUnitCostDataNow[index].endingRange.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 116, 196, 119),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: TextFormField(
                              controller: _textControllers[
                                  allUnitCostDataNow[index].endingRange],
                              decoration: const InputDecoration(
                                //hintText: allUnitCostAndOtherDataNow[index].rate,
                                labelStyle: TextStyle(color: Colors.white),
                                focusColor: Colors.white,
                                fillColor: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      tileColor: Color.fromARGB(255, 155, 219, 160),),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton.extended(
              // ... your existing FloatingActionButton code ...
               backgroundColor: Colors.green,
          foregroundColor: const Color.fromARGB(255, 21, 70, 23),
          onPressed: () {
            merge();
            updateUnitRangeCost();
            Navigator.pop(context);
          },
          label: const Text(
            'Confirm',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          ),
          ],
        ),
      ),
    ),
  );
}
}
