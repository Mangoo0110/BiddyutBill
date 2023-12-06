import 'dart:async';

import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/pdf_model.dart';
import 'package:e_bill/user_panel/user_dashboard/domain_layer.dart/fetchYearlyRecords.dart';
import 'package:flutter/material.dart';

class YearlyRecordHistory extends StatefulWidget {
  Map<String,MonthlyRecord?> records;
  List<UnitCost>unitCostData;
  String year;
  YearlyRecordHistory({super.key, required this.records, required this.unitCostData, required this.year});

  @override
  State<YearlyRecordHistory> createState() => _YearlyRecordHistoryState();
}

class _YearlyRecordHistoryState extends State<YearlyRecordHistory> {
  List<String>monthYear=[];

  final List<String> allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];


  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder:(context,constraints)=> ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          final month = allMonths[index];
          final record = widget.records[month];
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(month, style:const TextStyle(color: Colors.black, fontSize: 20),),
                ),
              ),
              Container(
                width: constraints.maxWidth,
                //height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 3
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: (record==null)?
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 30),
                  child:  Center(child: Text("No record", style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 19)),),
                ) 
                :
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Used Unit: ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                              Container(
                                decoration: BoxDecoration(
                                                color: Colors.orange.shade100,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(record.usedunit.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                                )
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Total(TK): ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                                Container(
                                  decoration: BoxDecoration(
                                                  color: Colors.green.shade100,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(record.finaltotalTk.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          child: InkWell(
                            onTap: () async{
                              UserPdfBillReciept billReciept = UserPdfBillReciept(unitCostData: widget.unitCostData, record: record, presentMonthYear: "$month, ${widget.year}");
                              await billReciept.generate();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                child: Text("Download pdf", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                              ),
                            ),
                          ),
                        )
                      ], 
                    ),
                  ),
                ),
              )
            ],
          );
        
        },
      ),
    );
  
  }
}