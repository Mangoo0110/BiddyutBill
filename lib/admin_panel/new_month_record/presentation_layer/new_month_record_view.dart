import 'dart:async';

import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/active_users_records.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/check_valid_double.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/final_total_calculation.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/get_all_unit_cost_range.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/get_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/push_all_records.dart';
import 'package:e_bill/admin_panel/new_month_record/presentation_layer/details_view.dart';
import 'package:e_bill/admin_panel/new_month_record/presentation_layer/month_picker.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';


class NewMonthRecord extends StatefulWidget {
  const NewMonthRecord({super.key});

  @override
  State<NewMonthRecord> createState() => _NewMonthRecordState();
}

class _NewMonthRecordState extends State<NewMonthRecord> {
  String searchText = "";
  List<String> allMonths=[
      "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ];
  String presentMonthAndYear= "";
  String previousMonthAndYear= "";
  final List<GlobalKey<FormState>> _presentMeterReadFormKeys = [];
  final List<GlobalKey<FormState>> _previousMeterReadFormKeys = [];

  late final StreamController _allRecordStreamController =
      StreamController.broadcast();

  final TextEditingController _searchBoxTextEditingController =
      TextEditingController();
  
   final List<TextEditingController> _previousMeterReadControllers = [];
   final List<TextEditingController> _presentMeterReadControllers = [];
   List<User> allUsers = [];
   List<String> labels = [
    name,
    occupatioN,
    previousMeterReading,
    presentMeterReading,
    finalTotalTk,
   ];
   List<UnitCost> allUnitCost = [];
   List<DemandChargeVatPercentage> demandChargeAndVatPercentage =[];
   List<MonthlyRecord>allRecordOfThisMonth = [];
   List<MonthlyRecord> searchedRecords = [];
   List<MonthlyRecord> pushCanditates = [];
     @override
  void initState() {
    
    presentMonthAndYear =  "${allMonths[DateTime.now().month-1].toLowerCase()}_${DateTime.now().year.toString()}";
    int prvYear = DateTime.now().year;
    if(DateTime.now().month==1){
      prvYear = prvYear - 1;
      previousMonthAndYear = allMonths[11].toLowerCase() + "_" + prvYear.toString();
    }
    else{
      previousMonthAndYear =  allMonths[DateTime.now().month-2] + DateTime.now().year.toString();
    }
    
    print(presentMonthAndYear);
    print(previousMonthAndYear);
    Future.delayed(const Duration(seconds:2),()async{
    allUnitCost = await getAllUnitCost();
    demandChargeAndVatPercentage = await getDemandChargeAndVatPercentage();
    allRecordOfThisMonth = await getAllActiveUserRecords(previousMonthAndYear: previousMonthAndYear, presentMonthAndYear:  presentMonthAndYear,demandChargeAndVatPercentage: demandChargeAndVatPercentage);
    _allRecordStreamController.sink.add(allRecordOfThisMonth);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchBoxTextEditingController.dispose();
    super.dispose();
  }

   Future<void>reload()async{
    allRecordOfThisMonth = await getAllActiveUserRecords(previousMonthAndYear: previousMonthAndYear,presentMonthAndYear: monthAndYear, demandChargeAndVatPercentage: demandChargeAndVatPercentage);
    _allRecordStreamController.sink.add(allRecordOfThisMonth);
   }

   Future searchedRecordStream() async{
    searchedRecords = [];
    for(int index = 0; index<allRecordOfThisMonth.length; index++){
      if(allRecordOfThisMonth[index].fullName.toLowerCase().contains(searchText.toLowerCase())) {
        searchedRecords.add(allRecordOfThisMonth[index]);
    }
    _allRecordStreamController.sink.add(searchedRecords);
   }
   }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    print("monthYear = $presentMonthAndYear");
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5)
                  ),
                    child: Row(children: [
                     const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.date_range,size: 20,),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              transitionDuration: const Duration(milliseconds: 500),
                              reverseTransitionDuration: const Duration(milliseconds: 500),
                              pageBuilder: (context,b,e){
                                return MonthPickerUI(monthAndYear: presentMonthAndYear,
                                  onDone: (pickedPreviousMonthAndYear, pickedPresentMonthAndYear) {
                                    Future.delayed(const Duration(seconds: 1),() async{
                                  allRecordOfThisMonth = await getAllActiveUserRecords(previousMonthAndYear: pickedPreviousMonthAndYear,presentMonthAndYear: pickedPresentMonthAndYear, demandChargeAndVatPercentage: demandChargeAndVatPercentage);
                                  _allRecordStreamController.sink.add(allRecordOfThisMonth);
                                  });
                                  Navigator.pop(context);
                                  setState(() {
                                  _allRecordStreamController.sink.add(allRecordOfThisMonth);
                                  presentMonthAndYear = pickedPresentMonthAndYear;
                                  previousMonthAndYear = pickedPreviousMonthAndYear;
                                  print("selected date: $presentMonthAndYear");
                                  });
                                  },
                                  );
                              },
                            )
                          );
                        },
                         child: const Text("Pick a date",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17),))
                    ],)
                  ),
                ),
              
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: TextButton(
                    onPressed: () async{
                      await pushallRecords(allRecordOfThisMonth, presentMonthAndYear);
                      setState(() {
                        reload();
                      });
                    },
                    child: const Text("Push all",style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_left,
                        color: Colors.black,
                        weight: 70,
                        size: 20,
                      ),
                      label: const Text(
                        "Back to control panel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17,color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _searchBoxTextEditingController,
                    decoration: const InputDecoration(
                      hintText: " Search...",
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (text) {
                      setState(() {
                      searchText = _searchBoxTextEditingController.text;
                      searchedRecordStream();
                      });
                    },
                  ),
                ),
              ),
            ),
            Text("Showing result from date : $presentMonthAndYear",style: const TextStyle(color: Colors.white70, fontSize: 18),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                  stream:  _allRecordStreamController.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          var thisMonthRecords = snapshot.data as List<MonthlyRecord>;
                          if (thisMonthRecords.isEmpty) {
                            return const Center(
                                child: Text(
                              "No user!!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.grey),
                            ));
                          }
                          else {
                          for (int index = 0; index<thisMonthRecords.length; index++){
                            thisMonthRecords[index]= calcOfFinalTotal(record: thisMonthRecords[index], demandChargeAndVatPercentage: demandChargeAndVatPercentage, allUnitCost: allUnitCost);
                          }
                          return Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10)
                                      
                                    ),
                                    child: ListView.builder(
                                      itemCount: thisMonthRecords.length,
                                      itemBuilder: (context, index) {
                                        MonthlyRecord record = thisMonthRecords[index];
                                        _presentMeterReadControllers.add(TextEditingController());
                                        _previousMeterReadControllers.add(TextEditingController());
                                        _previousMeterReadControllers[index].text = record.previousmeterReading.toString();
                                        _presentMeterReadControllers[index].text = record.presentmeteRreading.toString();
                                        _presentMeterReadControllers[index].selection 
                                                               = TextSelection.collapsed(offset: _presentMeterReadControllers[index].text.length);
                                        _previousMeterReadControllers[index].selection =
                                                                TextSelection.collapsed(offset: _previousMeterReadControllers[index].text.length);
                                        _presentMeterReadFormKeys.add(GlobalKey<FormState>());
                                        _previousMeterReadFormKeys.add(GlobalKey<FormState>());
                                        return Column(
                                          children: [
                                            const Divider(
                                              thickness: 2,
                                            ) ,
                                            Container(                                            
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6),
                                                
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  customDuoLabel("Name: ", record.fullName, Colors.black54, Colors.black54),

                                                  customDuoLabel("Occupation: ", record.occupation, Colors.black54, Colors.black54),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                           color: Colors.orange.shade100,
                                                           borderRadius: BorderRadius.circular(3),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          child: TextFormField(
                                                            key: _previousMeterReadFormKeys[index],
                                                            controller: _previousMeterReadControllers[index],
                                                            validator: (value) {
                                                              if(!isValidDoubleText(text: value!)){
                                                                return "Enter valid a number";
                                                              }
                                                            },
                                                            onChanged: (value) {
                                                             if(value.length>10){
                                                              _previousMeterReadControllers[index].text = thisMonthRecords[index].previousmeterReading.toString();
                                                             }
                                                             else{
                                                            if(_previousMeterReadControllers[index].text ==''){
                                                              print("why......");
                                                              setState(() {
                                                                _previousMeterReadControllers[index].text = '0';
                                                                thisMonthRecords[index].previousmeterReading = 0 ;                                                               
                                                              });
                                                              
                                                            }
                                                            
                                                              if(isValidDoubleText(text: _previousMeterReadControllers[index].text)){
                                                                print("why not...");
                                                                thisMonthRecords[index].previousmeterReading = double.parse(_previousMeterReadControllers[index].text) ;
                                                                if(!value.endsWith(".")){
                                                                  setState(() {
                                                                    
                                                                  });
                                                                }
                                                              }
                                                              else{
                                                                setState(() {
                                                                  _previousMeterReadControllers[index].text = thisMonthRecords[index].previousmeterReading.toString();
                                                                });
                                                              }
                                                             }
                                                            
                                                            //  setState(() {                                                  
                                                            //   thisMonthRecords[index].previousmeterReading = double.parse(_previousMeterReadControllers[index].text) ;                                                               
                                                            //   });
                                                            },
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            decoration: InputDecoration(
                                                              labelText: labels[2],
                                                              labelStyle: TextStyle(color: Colors.orange.shade600),
                                                              fillColor: Colors.orange.shade200,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                             color: Colors.green.shade100,
                                                             borderRadius: BorderRadius.circular(3)
                                                          ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                          ),
                                                          child: TextFormField(                                                       
                                                            key: _presentMeterReadFormKeys[index],
                                                            controller: _presentMeterReadControllers[index],
                                                            
                                                            validator: (value) {
                                                              if(!isValidDoubleText(text: value!)){
                                                                return "Enter a valid number";
                                                              }
                                                              
                                                            },
                                                            onChanged: (value) {
                                                             if(value.length>10){
                                                              _presentMeterReadControllers[index].text = thisMonthRecords[index].presentmeteRreading.toString();
                                                             }
                                                             else{
                                                            if(_presentMeterReadControllers[index].text ==''){
                                                              print("why......");
                                                              setState(() {
                                                                _presentMeterReadControllers[index].text = '0';
                                                                thisMonthRecords[index].presentmeteRreading = 0 ;                                                               
                                                              });
                                                              
                                                            }
                                                            
                                                              if(isValidDoubleText(text: _presentMeterReadControllers[index].text)){
                                                                print("why not...");
                                                                thisMonthRecords[index].presentmeteRreading= double.parse(_presentMeterReadControllers[index].text) ;
                                                                if(!value.endsWith(".")){
                                                                  setState(() {
                                                                    
                                                                  });
                                                                }
                                                              }
                                                              else{
                                                                setState(() {
                                                                  _presentMeterReadControllers[index].text = thisMonthRecords[index].presentmeteRreading.toString();
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
                                                              hoverColor: Colors.greenAccent.shade200,
                                                              fillColor: Colors.blueGrey,
                                                              labelText: labels[3],
                                                              labelStyle: TextStyle(color: Colors.green.shade600)
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                customDuoLabel("Total (TK) : ", record.finaltotalTk.toString(), Colors.black, Colors.black),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                          PageRouteBuilder(
                                                            opaque: false,
                                                            pageBuilder: (context, animation, secondaryAnimation) {
                                                              return RecordDetails(monthOfRecord: presentMonthAndYear, record: thisMonthRecords[index]);
                                                            },
                                                          )
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.green.shade100,
                                                          borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(10.0),
                                                          child: Text("Details",style: TextStyle(color: Colors.green,fontSize: 18),),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                     
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                          }
                        } else {
                          return const Center(
                            child: Text("Facing some problems!!"),
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

  Widget customDuoLabel(String label1, String label2, Color color1, Color color2){
   return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(label1,style: const TextStyle(fontSize: 20,color: Colors.black54),),
                  Text(label2,style: const TextStyle(fontSize: 20,color: Colors.black54)),
                ],
              ),
            ),
          ),
        );
  }
}
