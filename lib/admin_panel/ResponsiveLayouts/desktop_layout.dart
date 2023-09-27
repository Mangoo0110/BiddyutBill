import 'package:e_bill/admin_panel/houseTab/presentation_layer/all_house_view.dart';
import 'package:e_bill/admin_panel/new_month_record/presentation_layer/new_month_record_view.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/unit_range_cost.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/user_list.dart';
import 'package:e_bill/authentication/presentation_layer/logIn.dart';
import 'package:e_bill/constants/responsive_constants.dart';
import 'package:e_bill/constants/routes.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {

  final PageController _pageController = PageController();

  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String adminName = "bot";
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Drawer(
              backgroundColor: defaultColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                       DrawerHeader(child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Good day, Admin"),
                            // Padding(
                            // padding: const EdgeInsets.all(4.0),
                            // child: InkWell(
                            //   onTap: () {
                            //     Navigator.of(context).push(PageRouteBuilder(
                            //           opaque: false,
                            //           transitionDuration: const Duration(milliseconds: 500),
                            //           reverseTransitionDuration: const Duration(milliseconds: 500),
                            //           pageBuilder: (BuildContext context, b, e) {
                            //             return  NewMonthRecord();
                            //           }));
                            //   },
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(6),
                            //       color: Colors.orange.shade200,
                            //       border: Border.all(width: 2,color: Colors.white)
                            //     ),
                            //     // width: size.width * 0.2,
                            //     // height: size.height * 0.08,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Image.asset("images/thunder.png",color: Colors.orange,height: 30, width: 30,),
                            //           Text("B I L L I N G  P A N E L",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //             ),
              
                          ],
                        )),
                      ListTile(
                      tileColor: (_index==0)?Colors.green.shade300 : Colors.transparent,
                        leading: Image.asset("images/thunder.png",color: (_index==0)?Colors.orange:Colors.black38,height: 30, width: 30,),
                        title: const Text("B I L L I N G "),
                        onTap: (){
                          setState(() {
                          _index = 0;
                        });
                        _pageController.jumpToPage(0);
                        },
                      ),
                      ListTile(
                      tileColor: (_index==1)?Colors.green.shade200 : Colors.transparent,
                        leading:  Icon(Icons.home_work,color: (_index==1)?Colors.green:Colors.black38,),
                        title: const Text("H O U S E S"),
                        onTap: (){
                          setState(() {
                          _index = 1;
                        });
                        _pageController.jumpToPage(1);
                        },
                      ),
                      ListTile(
                        tileColor: (_index==2)?Colors.green.shade300 : Colors.transparent,
                        leading:  Icon(Icons.monetization_on,color: (_index==2)?Colors.amber.shade600:Colors.black38,),
                        title: const Text("U N I T C O S T"),
                        onTap: (){
                          setState(() {
                          _index = 2;
                        });
                        _pageController.jumpToPage(2);
                        },
                      ),
                      ListTile(
                        tileColor: (_index==3)?Colors.green.shade300 : Colors.transparent,
                        leading:  Icon(Icons.person_2_rounded,color: (_index==3)?Colors.blue:Colors.black38,),
                        title: const Text("U S E R S"),
                        onTap: (){
                          setState(() {
                          _index = 3;
                        });
                        _pageController.jumpToPage(3);
                        },
                      ),
                      ListTile(
                        tileColor: (_index==4)?Colors.green.shade300 : Colors.transparent,
                        leading:  Icon(Icons.message_outlined,color: (_index==4)?Colors.white:Colors.black38,),
                        title: const Text("C O M P L A I N S"),
                        onTap: (){
                          setState(() {
                          _index = 4;
                        });
                        _pageController.jumpToPage(4);
                        },
                      ),]),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogIn()), (route) => false);
                          },
                          title: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Logout", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Icon(Icons.logout),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                ],
              ),),
                  
                  ),

                  Expanded(
                    flex: 5,
                    child: Scaffold(
                      backgroundColor: Colors.black,
                      // appBar: AppBar(
                      //   title: const Center(
                      //       child: Text(
                      //     "C o n t r o l  P a n e l",
                      //     style: TextStyle(color: Colors.white),
                      //   )),
                      //   backgroundColor: Colors.black,
                      //  ),
                      
                      body: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: PageView.builder(
                          itemCount: 5,
                          controller: _pageController,
                          onPageChanged: (page) {
                            setState(() {
                              _index = page;
                            });
                          },
                          itemBuilder: (context, page) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 4, color: Colors.white70),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: chooseBot(context, page),
                            );
                          },
                        ),
                      ),
                        ),
                  ),
                    ],));
                    
  }

  Widget userComplains(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: const Center(
        child: Text(
          "No complains yet!!",
          style: TextStyle(fontSize: 27,color: Colors.white54),
        ),
      ),
    );
  }

  Widget chooseBot(BuildContext context, int pageIndex) {
    if(pageIndex == 0) return const NewMonthRecord();
    if (pageIndex == 1) return const AllHouseView();
    if (pageIndex == 2) return const UnitRangeCost();
    if (pageIndex == 3) {
      return const UserList();
    }

      return userComplains(context);
    
  }
}