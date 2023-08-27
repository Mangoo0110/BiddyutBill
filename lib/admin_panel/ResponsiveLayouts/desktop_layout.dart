import 'package:e_bill/admin_panel/houseTab/presentation_layer/all_house_view.dart';
import 'package:e_bill/admin_panel/unitCostTab/presentation_layer/unit_range_cost.dart';
import 'package:e_bill/admin_panel/usersTab/presentation_layer/user_list.dart';
import 'package:e_bill/constants/responsive_constants.dart';
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
                children: [
                  const DrawerHeader(child: Text("Good day, Admin")),
                  ListTile(
                  tileColor: (_index==0)?Colors.green.shade300 : Colors.transparent,
                    leading: const Icon(Icons.home_work,),
                    title: const Text("H O U S E S"),
                    onTap: (){
                      setState(() {
                      _index = 0;
                    });
                    _pageController.jumpToPage(0);
                    },
                  ),
                  ListTile(
                    tileColor: (_index==1)?Colors.green.shade300 : Colors.transparent,
                    leading: const Icon(Icons.monetization_on,),
                    title: const Text("U N I T C O S T"),
                    onTap: (){
                      setState(() {
                      _index = 1;
                    });
                    _pageController.jumpToPage(1);
                    },
                  ),
                  ListTile(
                    tileColor: (_index==2)?Colors.green.shade300 : Colors.transparent,
                    leading: const Icon(Icons.person_2_rounded,),
                    title: const Text("U S E R S"),
                    onTap: (){
                      setState(() {
                      _index = 2;
                    });
                    _pageController.jumpToPage(2);
                    },
                  ),
                  ListTile(
                    tileColor: (_index==3)?Colors.green.shade300 : Colors.transparent,
                    leading: const Icon(Icons.message_outlined,),
                    title: const Text("C O M P L A I N S"),
                    onTap: (){
                      setState(() {
                      _index = 3;
                    });
                    _pageController.jumpToPage(3);
                    },
                  ),]),),
                  ),

                  Expanded(
                    flex: 5,
                    child: Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        title: const Center(
                            child: Text(
                          "C o n t r o l  P a n e l",
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.black,
                       ),
                      body: Padding(
                        padding: const EdgeInsets.only(top: 8),
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
                        ),
                  ),
                    ],));
                    
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
    if (pageIndex == 1) return const UnitRangeCost();
    if (pageIndex == 2) {
      return const UserList();
    } else {
      return userComplains(context);
    }
  }
}