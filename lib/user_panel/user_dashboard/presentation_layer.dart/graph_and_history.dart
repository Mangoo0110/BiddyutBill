import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/user_panel/constants/ui_style.dart';
import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/yearly_data_model.dart';
import 'package:e_bill/user_panel/user_dashboard/domain_layer.dart/fetchYearlyRecords.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/bar_graph.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/yearly_history.dart';
import 'package:flutter/material.dart';

class GraphAndHistory extends StatefulWidget {
  int year;
  User user;
  GraphAndHistory({super.key, required this.year, required this.user});

  @override
  State<GraphAndHistory> createState() => _GraphAndHistoryState();
}

class _GraphAndHistoryState extends State<GraphAndHistory> {
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

  List<UnitCost> unitCostData = [];
  Future<Map<String,MonthlyRecord?>> yearlyRecordData()async{
    fillMonthYears();
    await fetchUnitCostData();
    return await fetchYearlyRecordsForUser(allMonths, monthYear, widget.user);
  }

  Future<void>fetchUnitCostData()async{
    unitCostData =  await UnitCostStorage().fetchAllUnitCost();
  }

  void fillMonthYears(){
    print("fillmonths ${widget.year}");
    int year = widget.year;
    monthYear = [];
    for(int index = 0; index<12; index++){
      monthYear.add(databaseMonthlyRecordNameformat(allMonths[index], year));
    }
  }

  String databaseMonthlyRecordNameformat(String month, int year){
    return "${month.toLowerCase()}_${year.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: yearlyRecordData(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return  Center(
            child: Text(snapshot.error.toString())
          );
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasData){
          if(snapshot.hasData){
            final records = snapshot.data as Map<String,MonthlyRecord?>;
            final yearlyData = YearlyData(records: records);
            return Expanded(
                    child: SingleChildScrollView(
                      child:  Column(
                        children: [
                          Align(alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text("Monthly Graph",style: AppStyle().headerOne,),
                          )),
                          SizedBox(
                            height: size.height * .35,
                            child: BarGraph(yearlyDataModel: yearlyData)),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: 
                            Column(
                              children: [
                                Align(alignment: Alignment.topLeft,child: Text("History",style: AppStyle().headerOne,)),
                                Container(
                                  height: size.height * .4,
                                  child: YearlyRecordHistory(records: records, unitCostData: unitCostData),
                                )
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  );
                            
          }
          else{
            return const Center(
            child: Text("No Data")
          );
          }
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}