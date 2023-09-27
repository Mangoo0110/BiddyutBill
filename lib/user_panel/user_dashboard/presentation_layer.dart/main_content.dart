import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/user_panel/constants/ui_colors.dart';
import 'package:e_bill/user_panel/constants/ui_style.dart';
import 'package:flutter/material.dart';

class UserDashboardMainContent extends StatelessWidget {
  final User? user;
  const UserDashboardMainContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
      child: Column(
        children: [
          Column(
            children: [
              Align(alignment: Alignment.topLeft, child: Text("Dashboard",style: AppStyle().headerOne,)),
              Align(alignment: Alignment.topLeft, child: Text("Monthly Electric Bill Details",style: AppStyle().normalText,)),
            ],
          ),
          Expanded(
          child: 
            (user==null)? const Center(child: CircularProgressIndicator())
            :
            Column(
              children: [
                Row(
                  children: [
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
                                  child: Align(alignment: Alignment.topLeft, child: Text("Building: ${user!.buildingName}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 17),)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(alignment: Alignment.topLeft, child: Text("House No: ${user!.houseNo}",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),)),
                                ),
                              ],
                            )
                          ],
                        ),
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
                                        Text("Used Unit: ",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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
                                    )),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(8.0),
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
                                    )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}