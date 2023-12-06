// ignore_for_file: no_logic_in_create_state
import 'dart:convert';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_and_other_constant.dart';
import 'package:e_bill/common_logic/check_valid_double.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
class UpdateVatAndDemand extends StatefulWidget {
  DemandChargeVatPercentage vatAndDemandData;
  UpdateVatAndDemand({super.key, required this.vatAndDemandData});
  
  @override
  State<UpdateVatAndDemand> createState() => _UpdateVatAndDemandState();
}

class _UpdateVatAndDemandState extends State<UpdateVatAndDemand> {
  TextEditingController vatTextEditingController = TextEditingController();

  TextEditingController demandChargeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    vatTextEditingController.text = widget.vatAndDemandData.vatPercentageTk.toString();
    demandChargeTextEditingController.text = widget.vatAndDemandData.demandChargeTk.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color.fromARGB(255, 222, 250, 223),
        content: SizedBox(
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
                                    onChanged: (value) {
                                      if (value.length > 10) {
                                        setState(() {
                                          vatTextEditingController.text =
                                              widget.vatAndDemandData.vatPercentageTk.toString();
                                        });
                                      }
                                      else {
                                        if (vatTextEditingController.text =='') {
                                          setState(() {
                                            vatTextEditingController.text = '0';
                                            widget.vatAndDemandData.vatPercentageTk = 0;
                                          });
                                        }
                                        if (isValidDoubleText( text: vatTextEditingController.text)) {
                                          if (!value.endsWith(".")) {
                                            setState(() {
                                              widget.vatAndDemandData.vatPercentageTk =
                                                  double.parse(vatTextEditingController.text);
                                            });
                                          }
                                        } 
                                        else {
                                          setState(() {
                                            vatTextEditingController.text =
                                                widget.vatAndDemandData.vatPercentageTk.toString();
                                          });
                                        }
                                      }
                                    },
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
                                    onChanged: (value) {
                                      if (value.length > 10) {
                                        setState(() {
                                          demandChargeTextEditingController.text =
                                              widget.vatAndDemandData.demandChargeTk.toString();
                                        });
                                      }
                                      else {
                                        if (demandChargeTextEditingController.text =='') {
                                          setState(() {
                                            demandChargeTextEditingController.text = '0';
                                            widget.vatAndDemandData.demandChargeTk = 0;
                                          });
                                        }
                            
                                        if (isValidDoubleText( text: demandChargeTextEditingController.text)) {
                                          if (!value.endsWith(".")) {
                                            setState(() {
                                              widget.vatAndDemandData.demandChargeTk =
                                                  double.parse(demandChargeTextEditingController.text);
                                            });
                                          }
                                        } 
                                        else {
                                          setState(() {
                                            demandChargeTextEditingController.text =
                                                widget.vatAndDemandData.demandChargeTk.toString();
                                          });
                                        }
                                      }
                                    },
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
                const SizedBox(
                  height: 16,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.green.shade200,
                  foregroundColor: const Color.fromARGB(255, 21, 70, 23),
                  onPressed: () async{
                    var res = await DemandChargeVatPercentageStorage().updateVatAndDemand(updatedVatAndDemandData: widget.vatAndDemandData);
                    if(res == true){
                      Future.delayed(const Duration(seconds: 1),(){
                        Navigator.pop(context);
                      });
                    }
                  },
                  label: const Text(
                    'Confirm',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ],
            )
          )
        )
      );
  }
}
