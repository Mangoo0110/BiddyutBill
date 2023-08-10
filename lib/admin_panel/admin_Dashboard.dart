import 'dart:async';

import 'package:e_bill/admin_info/adminModel.dart';
import 'package:e_bill/admin_panel/houseTab/houseView/allhouseView.dart';
import 'package:e_bill/admin_panel/unitCostTab/unitCostView.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:e_bill/admin_info/adminPreferences.dart';

class AdminHome extends StatefulWidget {
  
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHome> {
  
  final PageController _pageController = PageController();
  int _index = 0;
  @override
  void dispose() {
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String adminName = "bot";
    return  Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: const Center(
                      child: Text(
                    "C o n t r o l  P a n e l",
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.black,
                  leading: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        const Text(
                          "Hello,",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          adminName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.green.shade300, width: 2),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: PageView.builder(
                    itemCount: 4,
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        _index = page;
                      });
                    },
                    itemBuilder: (context, page) {
                      print(page);
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
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  child: Container(
                    color: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GNav(
                          gap: 30,
                          backgroundColor: Colors.transparent,
                          tabBackgroundColor: Colors.green.shade200,
                          //padding: const EdgeInsets.all(19),
                          tabBorderRadius: 28,
                          selectedIndex: _index,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          tabs: [
                            GButton(
                              icon: Icons.home_work,
                              text: "Houses",
                              textColor: Colors.white,
                              iconActiveColor: Colors.green,
                              iconColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .060,
                                  vertical: size.height * 0.025),
                            ),
                            GButton(
                              icon: Icons.monetization_on,
                              text: "Unit Cost",
                              textColor: Colors.white,
                              iconActiveColor: Colors.green,
                              iconColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .060,
                                  vertical: size.height * 0.025),
                            ),
                            GButton(
                              icon: Icons.person_add,
                              text: "Add User",
                              textColor: Colors.white,
                              iconActiveColor: Colors.green,
                              iconColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .060,
                                  vertical: size.height * 0.025),
                            ),
                            GButton(
                              icon: Icons.message_outlined,
                              text: "Complains",
                              textColor: Colors.white,
                              iconActiveColor: Colors.green,
                              iconColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .060,
                                  vertical: size.height * 0.025),
                            ),
                          ],
                          onTabChange: (index) {
                            setState(() {
                              _index = index;
                            });
                            _pageController.jumpToPage(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );}
              
  

  Widget addUser(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.shade300,
      ),
    );
  }

  Widget userComplains(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade300,
      ),
    );
  }

  Widget chooseBot(BuildContext context, int pageIndex) {
    if (pageIndex == 0) return const AllHouseView();
    if (pageIndex == 1) return const UnitCostView();
    if (pageIndex == 2)
      return addUser(context);
    else
      return userComplains(context);
  }
}
