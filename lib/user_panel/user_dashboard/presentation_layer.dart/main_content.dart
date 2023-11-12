import 'dart:math';

import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/user_panel/constants/ui_colors.dart';
import 'package:e_bill/user_panel/constants/ui_style.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/bar_graph.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/graph_and_history.dart';
import 'package:e_bill/user_panel/user_dashboard/presentation_layer.dart/yearly_history.dart';
import 'package:flutter/material.dart';

class UserDashboardMainContent extends StatefulWidget {
  final User? user;
  UserDashboardMainContent({super.key, required this.user});

  @override
  State<UserDashboardMainContent> createState() => _UserDashboardMainContentState();
}

class _UserDashboardMainContentState extends State<UserDashboardMainContent> {
  late int _dropDownYearValue;

  List<int> years = [];

  getYears(){
    for (int year = 2010; year <= DateTime.now().year; year++){
      years.add(year);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getYears();
    _dropDownYearValue = DateTime.now().year;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
      SizedBox(
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
          child: Column(
            children: [
              Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Dashboard",style: AppStyle().headerOne,)),
                  Align(alignment: Alignment.topLeft, child: Text("Monthly Electric Bill Details",style: AppStyle().normalText,)),
                ],
              ),
              (widget.user==null)? const Expanded(flex: 20, child: Center(child: CircularProgressIndicator()))
              :
              Expanded(
                flex: 30,
                child: SizedBox(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 210,
                                  height: 190,
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Icon(Icons.home,size: 45,),
                                          ),
                                          
                                        ],
                                      ),
                                      Column(
                                        children: [
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text("House",style: TextStyle(color: Colors.black45, fontSize: 19),),
                                                  ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.topLeft, child: Text("Building: ${widget.user!.buildingName}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 17),)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(alignment: Alignment.topLeft, child: Text("House No: ${widget.user!.houseNo}",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 210,
                                    height: 190,
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(Icons.monetization_on,size: 45,),
                                            ),
                                            
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                            padding:  EdgeInsets.all(8.0),
                                            child: Text("September, 2023",style: TextStyle(color: Colors.black45, fontSize: 19),),
                                          ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Row(
                                                  children: [
                                                    const Text("Used Unit: ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                                      color: Colors.orange.shade100,
                                                                      borderRadius: BorderRadius.circular(4),
                                                                    ),
                                                      child: const Padding(
                                                        padding:  EdgeInsets.symmetric(horizontal: 16),
                                                        child: Text("125.43", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                                                      ))
                                                  ],
                                                )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Row(
                                                  children: [
                                                    const Text("Total(TK): ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                                      color: Colors.green.shade100,
                                                                      borderRadius: BorderRadius.circular(4),
                                                                    ),
                                                      child: const Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                                        child: Text("1023", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                                                      ))
                                                  ],
                                                )
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 2),
                                 child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Text("Year", style: TextStyle(fontSize: max(15,size.width * .012),color: Colors.black, fontWeight: FontWeight.bold),),
                                    ),
                                    DropdownButton(
                                      items: years.map((year) => 
                                            DropdownMenuItem<int>(
                                              value: year,
                                              child:  Text(year.toString(), style: TextStyle(fontSize: max(15,size.width * .012),color: Colors.black),),
                                              )).toList(),
                                      value: _dropDownYearValue,
                                      onChanged: (selectedValue){
                                                  setState(() {
                                                    _dropDownYearValue = selectedValue??_dropDownYearValue;
                                                  });
                                      },
                                    ),
                                  ],
                                 ),
                               ),
                              GraphAndHistory(year: _dropDownYearValue, user: widget.user!)
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    
  }
}