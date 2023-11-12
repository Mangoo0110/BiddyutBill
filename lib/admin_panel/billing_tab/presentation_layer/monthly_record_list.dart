import 'dart:async';

import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/final_total_calculation.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/generate_record_key.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/riverpod_monthly_record_helper.dart';
import 'package:e_bill/admin_panel/billing_tab/presentation_layer/details_view.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/common_logic/check_valid_double.dart';
import 'package:e_bill/constants/responsive_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthlyRecordListView extends ConsumerStatefulWidget {
  List<String> labels;
  MonthlyRecordListView(
      {super.key,
      required this.labels,});

  @override
  ConsumerState<MonthlyRecordListView> createState() => _MonthlyRecordListViewState();
}
class _MonthlyRecordListViewState extends ConsumerState<MonthlyRecordListView> {
  final List<GlobalKey<FormState>> _presentMeterReadFormKeys = [];
  final List<GlobalKey<FormState>> _previousMeterReadFormKeys = [];
  List<MonthlyRecord>thisMonthRecords = [];
  final List<TextEditingController> _previousMeterReadControllers = [];
  final List<TextEditingController> _presentMeterReadControllers = [];

  updateReadyToPushState(String recordKey, bool state){
    var recordPushStates = ref.read(readyToPushProvider);
    recordPushStates[recordKey] = state;
    ref.watch(readyToPushProvider.notifier).update((state) => recordPushStates);
    
  }
  bool getReadyToPushState(String recordKey){
    var recordPushStates = ref.read(readyToPushProvider);
    if(recordPushStates[recordKey]==null)recordPushStates[recordKey]=false;
    return recordPushStates[recordKey]!;
  }
  updateToBePushRecords(){
    ref.read(recordsToBePushProvider.notifier).update((state) => thisMonthRecords);
  }
  @override
  void initState() {
      
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ref.watch(readyToPushProvider);
    var size = MediaQuery.of(context).size;
    var searchedData = ref.watch(searchedMonthlyRecordsProvider);
    return 
      searchedData.when(
        error: (error, stackTrace){
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
              child: const Center(child: Center(child: Text("Internal error!!")),
            ),
          )
          );
        },
        loading: () {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
              child: const Center(child: Center(child: CircularProgressIndicator(),)),
            ),
          );
        },
        data: (data) {
          thisMonthRecords = data;
          final _allUnitCost = ref.watch(allUnitCostProvider);
          return _allUnitCost.when(
            error: (error, stackTrace){
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
              child: const Center(child: Center(child: Text("Internal error!!")),
            ),
          )
          );
        },
        loading: () {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
              child: const Center(child: Center(child: CircularProgressIndicator(),)),
            ),
          );
        },
        data:(unitCostData) {
          for(int index = 0; index< thisMonthRecords.length; index++){
            thisMonthRecords[index] = calcOfFinalTotal(record: thisMonthRecords[index], allUnitCost: unitCostData);
          }
          return Expanded(
            child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
                  child: (thisMonthRecords.isEmpty)?
                    const Center(child: Text("No Records",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                    :
                  ListView.builder(
                              itemCount: thisMonthRecords.length,
                              itemBuilder: (context, index) {
                                MonthlyRecord record = thisMonthRecords[index];
                                _presentMeterReadControllers.add(TextEditingController());
                                _previousMeterReadControllers.add(TextEditingController());
                                _previousMeterReadControllers[index].text =
                                record.previousmeterReading.toString();
                                _presentMeterReadControllers[index].text =
                                record.presentmeteRreading.toString();
                                _presentMeterReadControllers[index].selection =
                                  TextSelection.collapsed(
                                      offset:
                                          _presentMeterReadControllers[index].text.length);
                                              _previousMeterReadControllers[index].selection =
                                  TextSelection.collapsed(
                                      offset:
                                          _previousMeterReadControllers[index].text.length);
                                            _presentMeterReadFormKeys.add(GlobalKey<FormState>());
                                            _previousMeterReadFormKeys.add(GlobalKey<FormState>());
                                            return Container(
                                              color: Colors.blue.shade300,
                                              child: Table(
                                                columnWidths: const {0:FractionColumnWidth(.2),1:FractionColumnWidth(.2),
                                                  2:FractionColumnWidth(.15),3:FractionColumnWidth(.15),4:FractionColumnWidth(.12),
                                                  5:FractionColumnWidth(.09),6:FractionColumnWidth(.09),
                                                  },
                                                border: TableBorder.all(color: Colors.white),
                                                children: [
                                                    TableRow(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: customLabel("${record.buildingName}, ${record.houseNo}",
                                                              Colors.black54, size),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: customLabel(record.assignedUserID==""?"Empty":record.fullName,
                                                              Colors.black54,size),
                                                        ),
                                                        SizedBox(
                                                          height: 70,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.orange.shade100,
                                                                borderRadius: BorderRadius.circular(3),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal: 12),
                                                                child: TextFormField(
                                                                  key: _previousMeterReadFormKeys[index],
                                                                  controller: _previousMeterReadControllers[index],
                                                                  onChanged: (value) {
                                                                    if (value.length > 10) {
                                                                      setState(() {
                                                                        _previousMeterReadControllers[index].text =
                                                                            thisMonthRecords[index].previousmeterReading.toString();
                                                                            updateToBePushRecords();
                                                                      });
                                                                    } else {
                                                                      if (_previousMeterReadControllers[index].text =='') {
                                                                        setState(() {
                                                                          _previousMeterReadControllers[index].text = '0';
                                                                          thisMonthRecords[index].previousmeterReading = 0;
                                                                              updateToBePushRecords();
                                                                        });
                                                                      }
                                                          
                                                                      if ( isValidDoubleText(
                                                                          text:
                                                                              _previousMeterReadControllers[
                                                                                      index]
                                                                                  .text)) {
                                                                        if (!value.endsWith(".")) {
                                                                          setState(() {
                                                                            thisMonthRecords[index]
                                                                                    .previousmeterReading =
                                                                                double.parse(
                                                                                    _previousMeterReadControllers[
                                                                                            index]
                                                                                        .text);
                                                                                        updateToBePushRecords();
                                                                          });
                                                                        }
                                                                      } else {
                                                                        setState(() {
                                                                          _previousMeterReadControllers[index].text =
                                                                              thisMonthRecords[index].previousmeterReading.toString();
                                                                              updateToBePushRecords();
                                                                        });
                                                                      }
                                                                    }
                                                                    
                                                                  },
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  decoration: InputDecoration(
                                                                    border: InputBorder.none,
                                                                    //labelText: widget.labels[2],
                                                                    labelStyle: TextStyle(
                                                                        color: Colors.orange.shade600),
                                                                    fillColor: Colors.orange.shade200,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 70,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.green.shade100,
                                                                  borderRadius: BorderRadius.circular(3)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 12,
                                                                ),
                                                                child: Consumer(
                                                                  builder:(context, ref, child) =>TextFormField(
                                                                    key: _presentMeterReadFormKeys[index],
                                                                    controller:_presentMeterReadControllers[index],
                                                                    onChanged: (value) {
                                                                      if (value.length > 10) {
                                                                        setState(() {
                                                                          _presentMeterReadControllers[index].text =
                                                                              thisMonthRecords[index].presentmeteRreading.toString();
                                                                              updateToBePushRecords();
                                                                        });
                                                                      } else {
                                                                        if (_presentMeterReadControllers[index].text == '') {
                                                                          setState(() {
                                                                            _presentMeterReadControllers[index].text = '0';
                                                                            thisMonthRecords[index].presentmeteRreading = 0;
                                                                            updateToBePushRecords();
                                                                          });
                                                                        }
                                                                        if (isValidDoubleText(text:_presentMeterReadControllers[index].text)) {
                                                                          if (!value.endsWith(".")) {
                                                                            setState(() {
                                                                              thisMonthRecords[index].presentmeteRreading =
                                                                                  double.parse(_presentMeterReadControllers[index].text);
                                                                                  updateToBePushRecords();
                                                                            });
                                                                          }
                                                                        } else {
                                                                          setState(() {
                                                                            _presentMeterReadControllers[index].text =
                                                                                thisMonthRecords[index].presentmeteRreading.toString();
                                                                                updateToBePushRecords();
                                                                          });
                                                                        }
                                                                      }
                                                                      //updateToBePushRecords();
                                                                    },
                                                                    style: const TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                        hoverColor:
                                                                            Colors.greenAccent.shade200,
                                                                        fillColor: Colors.blueGrey,
                                                                        //labelText: widget.labels[3],
                                                                        labelStyle: TextStyle(
                                                                            color: Colors.green.shade600)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        
                                                        Center(
                                                          child: customLabel(
                                                              record.finaltotalTk.toString(),
                                                              Colors.black, size),
                                                        ),                                            
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(PageRouteBuilder(
                                                                opaque: false,
                                                                pageBuilder: (context, animation,
                                                                    secondaryAnimation) {
                                                                  return RecordDetails(
                                                                      monthOfRecord:ref.watch(selectedPresentMonthAndYear),
                                                                      record: thisMonthRecords[index]);
                                                                },
      
                                                              ));
                                                            },
                                                            child: Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 15),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white30,
                                                                      borderRadius: BorderRadius.circular(6)),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Text(
                                                                      "Details",
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                          color: Colors.black, fontSize: respTextSize(size: size)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      InkWell(
                                                        onTap: () {
                                                          var k = ref.watch(readyToPushProvider);
                                                          var state = k[record.assignedUserID];
                                                          if(state==null){
                                                            setState(() {
                                                              updateReadyToPushState(record.assignedUserID, false);
                                                            });
                                                          }
                                                          else{ setState(() {
                                                              updateReadyToPushState(record.assignedUserID, !state);
                                                            });
                                                          }
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: SizedBox(
                                                            height: 70,
                                                            child: Consumer(
                                                            builder:(context, ref, child) {
                                                              var k = ref.watch(readyToPushProvider);
                                                              var state = k[generateRecordKey(record)];
                                                              print("${record.fullName} $state");
                                                              return Center(
                                                              child: Checkbox(
                                                                value: state,
                                                                onChanged: (val) {
                                                                  if(val!=null){ 
                                                                  updateReadyToPushState(generateRecordKey(record), val);
                                                                  }
                                                                  else{
                                                                    updateReadyToPushState(generateRecordKey(record), true);
                                                                  }
                                                                  setState(() {
                                                                    
                                                                  });
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
                                          ),
                                        );
                                      },
                                    ),
                              ),
                            );
                          }, 
                        );
                    },
      );
  }

Widget customLabel(
  String label, Color color,Size size) {
      return SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(fontSize: respTextSize(size: size), color: Colors.black),
              ),
            ),
          ),
        ),
      );
  }
}
