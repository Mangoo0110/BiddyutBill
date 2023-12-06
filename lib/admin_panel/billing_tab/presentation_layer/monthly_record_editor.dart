
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/generate_record_key.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/pdf_generation.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/riverpod_monthly_record_helper.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/send_user_monthly_bill_email.dart';
import 'package:e_bill/admin_panel/billing_tab/presentation_layer/month_picker.dart';
import 'package:e_bill/admin_panel/billing_tab/presentation_layer/monthly_record_list.dart';
import 'package:e_bill/admin_panel/billing_tab/presentation_layer/pdf_ui.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/common_ui/confirm_dialog_box.dart';
import 'package:e_bill/common_ui/okay_dialog_box.dart';
import 'package:e_bill/constants/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NewMonthRecord extends ConsumerStatefulWidget {
  const NewMonthRecord({super.key});
  @override
  ConsumerState<NewMonthRecord> createState() => _NewMonthRecordState();
}

class _NewMonthRecordState extends ConsumerState<NewMonthRecord> {

  String searchText = "";
  bool selectedAll = false;
  bool typeA = false;
  bool typeB = false;
  bool typeS  = false;
  bool typeAll = true;
  bool emailService = false;
  final TextEditingController _searchBoxTextEditingController =
      TextEditingController();
  List<String> labels = [
    name,
    occupatioN,
    previousMeterReading,
    presentMeterReading,
    finalTotalTk,
  ];
  List<DemandChargeVatPercentage>demandVatList = [];
  recordSearching(){
    //print(" printing ${ref.watch(selectedUserType)}");
    ref.read(searchedRecordText.notifier).update((state) => searchText);
    var cc = ref.watch(monthlyRecordProvider);
    var dd = ref.watch(searchedMonthlyRecordsProvider);
  }

  String getSelectedDate(){
        var recordsDate = ref.read(selectedPresentMonthAndYear);
        return recordsDate;
  }
  markAllSelected(){
    var readyToPush = ref.read(readyToPushProvider);
    for(var readyState in readyToPush.keys){
      readyToPush[readyState] = selectedAll;
    }
    ref.read(readyToPushProvider.notifier).update((state) => readyToPush);
  }

  Future getAllRecordsOfThisMonth() async{
    var presentMonthAndYear = getSelectedDate();
    return MonthlyRecordStorage().fetchAllRecord(monthYear: presentMonthAndYear);
  }

  Future getAllUnitCost() async{
    return UnitCostStorage().fetchAllUnitCost();
  }

  Future getDemandAndVatList() async{
    return DemandChargeVatPercentageStorage().fetchDemandChargeVatPercentageStorage();
  }

  Future pushRecords()async{
    selectedAll = false;
    List<MonthlyRecord>failedToSend = [];
    List<MonthlyRecord>records = ref.read(recordsToBePushProvider);
    final readyToPush = ref.read(readyToPushProvider);
    String monthAndYear = ref.read(selectedPresentMonthAndYear);

    for (int index =0;index<records.length; index++){
      //print(readyToPush[generateRecordKey(records[index])]);
      if(readyToPush[generateRecordKey(records[index])]==true){
          readyToPush[generateRecordKey(records[index])] = false;
          var success =  await MonthlyRecordStorage().pushMonthlyRecord(monthYear: monthAndYear, record: records[index]);
          if(!success){
            failedToSend.add(records[index]);
          }
          else{
            if(emailService){
              success = await monthly_bill_email(record: records[index], monthAndYear: monthAndYear);
              if(!success){
                Fluttertoast.showToast(msg: "Failed sending user ${records[index].fullName} email");
              }
              else{
                Fluttertoast.showToast(msg: "Email sent to user ${records[index].fullName}");
              }
            }
          }
      }
  }
  ref.read(newRecordPush.notifier).update((state) => true);
  ref.watch(readyToPushProvider.notifier).update((state) => {});
  ref.watch(failedToPush.notifier).update((state) => failedToSend);
  }


  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
   @override
  void dispose() {
    // TODO: implement dispose
    _searchBoxTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder:(context,constraints)=> Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Expanded(
                     child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                         child: Container(
                           height: 50,
                           width: responsiveSearchWidth(boxConstraints: constraints),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(color: Colors.white,width: 2),
                             color: Colors.grey.shade300,
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: TextFormField(
                               controller: _searchBoxTextEditingController,
                               decoration: const InputDecoration(
                                border:  InputBorder.none,
                                 hintText: " Search by name...",
                                 hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
                                 focusColor: Colors.white,
                                 fillColor: Colors.white,
                               ),
                               //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                               cursorColor: Colors.black,
                               style: const TextStyle(color: Colors.black),
                               onChanged: (text) {
                                   searchText = _searchBoxTextEditingController.text;
                                   recordSearching();
                               },
                             ),
                           ),
                         ),
                       ),
                   ),
               
                  MonthPickerUI(
                    onDone: (){
                     //recordSearching();
                     Navigator.pop(context);
                     
                    },
                    onCancel: (){
                     Navigator.pop(context);
                    },
                  ),
                  Container(
                     decoration: BoxDecoration(
                         color: Colors.grey[200],
                         borderRadius: BorderRadius.circular(6)),
                     child: Padding(
                       padding: const EdgeInsets.all(2.0),
                       child:
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration:
                                        const Duration(milliseconds: 500),
                                          reverseTransitionDuration:
                                        const Duration(milliseconds: 200),
                                        pageBuilder:
                                        (BuildContext context, b, e) {
                                        return ConfirmDialogBox(
                                        titleText: "Push Selected Records",
                                        bodyText: "Are you sure to push records of ${ref.read(selectedPresentMonthAndYear)} to the database",
                                          onConfirm: ()async{
                                            Navigator.of(context).pop();
                                            //print("Push now");
                                            
                                            await pushRecords();
                                            var failedToSend = ref.read(failedToPush);
                                            if(failedToSend.isEmpty){
                                              Navigator.of(context).push(PageRouteBuilder(
                                                opaque: false,
                                                transitionDuration:
                                                const Duration(milliseconds: 500),
                                                  reverseTransitionDuration:
                                                const Duration(milliseconds: 200),
                                                pageBuilder:
                                                (BuildContext context, b, e) {
                                                return OkayDialogBox(
                                                onDone: () {
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                                }));
                                    
                                            }
                  
                                    ref.read(failedToPush.notifier).update((state) => []);
                                  },
                                    onCancel: (){
                                    Navigator.of(context).pop();
                                    }
                                    );
                                  },
                                ));
                              },
                              child:
                                Row(
                                  children:[
                                      const Icon(Icons.arrow_upward_sharp,color: Colors.orange,),
                                      Text("Push all marked",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints),
                                              color: Colors.black)),
                                      ],
                                  ),
                        ),
                     ),
                  ),
                  PDFUI(
                    pdfCallback: () async{
                      var presentMonthAndYear = getSelectedDate();
                      var allRecords = await getAllRecordsOfThisMonth();
                      var allUnitCost = await getAllUnitCost();
                      CreatePdf().generate(allRecordOfThisMonth: allRecords, presentMonth: presentMonthAndYear, unitCostData: allUnitCost, type: 1);
                      CreatePdf().generate(allRecordOfThisMonth: allRecords, presentMonth: presentMonthAndYear, unitCostData: allUnitCost, type: 2);
                      CreatePdf().generate(allRecordOfThisMonth: allRecords, presentMonth: presentMonthAndYear, unitCostData: allUnitCost, type: 3);
                    },
                  ),
                 ],
               ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Consumer(
                      builder: (context, ref, child){ 
                        ref.watch(selectedPresentMonthAndYear);
                        var month = getSelectedDate().split('_')[0].toUpperCase();
                        var year = getSelectedDate().split('_')[1];
                       return Text(
                        " $month, $year",
                        style:  TextStyle(color: Colors.black, fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints),),
                          );
                        }
                      ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 300 + size.width * .15,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: emailService,
                                  onChanged: (val){
                                    setState(() {
                                      emailService = val!;
                                    });
                                  }
                                  ),
                                    Text("Email Service",style: TextStyle(color: (emailService==true)?Colors.black: Colors.black87,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                    Icon(Icons.email,color: (emailService==true)?Colors.green: Colors.black26,),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("User Type :",style: TextStyle(color: Colors.black,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: (typeAll==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                  color: (typeAll==true)?Colors.green.shade200:Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row( 
                                    children: [
                                      Checkbox(
                                        value: typeAll,
                                        onChanged: (val){
                                          setState(() {
                                            typeAll = true;
                                            typeA = false;
                                            typeS = false;
                                            typeB = false;
                                            ref.read(selectedUserType.notifier).update((state) => "all");
                                          });
                                        }
                                      ),
                                      Text("All",style: TextStyle(color: (typeAll==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: (typeA==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                    color: (typeA==true)?Colors.green.shade200:Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: typeA,
                                        onChanged: (val){
                                          setState(() {
                                            typeA = true;
                                            typeAll = false;
                                            typeS = false;
                                            typeB = false;
                                            ref.read(selectedUserType.notifier).update((state) => aType);
                                          });
                                        }
                                      ),
                                      Text("A",style: TextStyle(color: (typeA==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: (typeB==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                    color: (typeB==true)?Colors.green.shade200:Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: typeB,
                                      onChanged: (val){
                                        
                                        setState(() {
                                          typeB = true;
                                          typeAll = false;
                                          typeA = false;
                                          typeS = false;
                                          ref.read(selectedUserType.notifier).update((state) => bType);
                                        });
                                      }
                                      ),
                                        Text("B",style: TextStyle(color: (typeB==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: (typeS==true)?Border.all(color: Colors.green.shade200):Border.all(color: Colors.white),
                                    color: (typeS==true)?Colors.green.shade200:Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: typeS,
                                      onChanged: (val){
                                        
                                        setState(() {
                                          typeS = true;
                                          typeAll = false;
                                          typeA = false;
                                          typeB = false;
                                          ref.read(selectedUserType.notifier).update((state) => sType);
                                        });
                                      }
                                      ),
                                        Text("S",style: TextStyle(color: (typeS==true)?Colors.black: Colors.black54,fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints)),),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                                            
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                    
                ],),
                   
                      Container(
                        color: Colors.blue,
                        child: Table(
                          columnWidths: const {0:FractionColumnWidth(.2),1:FractionColumnWidth(.2),
                                  2:FractionColumnWidth(.15),3:FractionColumnWidth(.15),4:FractionColumnWidth(.12),
                                  5:FractionColumnWidth(.09),6:FractionColumnWidth(.09),
                                  },
                          border: TableBorder.all(color: Colors.white),
                          children: [
                            TableRow(
                              children: [
                                customLabel("House", Colors.black),
                                customLabel("Habitant", Colors.black),
                                customLabel("Previous Meter Reading", Colors.black),
                                customLabel("Present Meter Reading", Colors.black),
                                customLabel("Total Cost", Colors.black),
                                customLabel("Details", Colors.black),
                                InkWell(
                                  onTap: (){
                                    {
                                    setState(() {
                                    selectedAll = !selectedAll;
                                    markAllSelected();
                                    });
                                  }
                                  },
                                  child: Column(
                                    children: [
                                      customLabel("Select All", Colors.black),
                                      SizedBox(
                                            child: Consumer(
                                             builder:(context, ref, child) {
                                               
                                              //  var k = ref.watch(readyToPushProvider);
                                              return Center(
                                               child: Checkbox(
                                                 value: selectedAll,
                                                 onChanged: (val) {
                                                   setState(() {
                                                  selectedAll = !selectedAll;
                                                   markAllSelected();
                                                   });
                                                 },
                                               ),
                                             );
                                             },
                                             
                                                ),
                                          ),
                                    ],
                                  ),
                                ),
                              ]
                            )
                          ],
                        ),
                      ),
                      
                    MonthlyRecordListView(labels: labels),            
            ],
          ),
        ),
      ),
    );
  }
    Widget customLabel(
      String label, Color color) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}