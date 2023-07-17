import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  PageController _pageController = PageController();
   int _index=0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Center(child:  Text("C o n t r o l  P a n e l",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: PageView.builder(
          itemCount: 4,
          controller: _pageController,
          onPageChanged: (page){
            setState(() {
              _index = page;
            });
          },
          itemBuilder: (context,page){
            print(page);
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.white70
                ),
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
          vertical: 3,
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
                gap: size.width * .04,
                backgroundColor: Colors.transparent,
                tabBackgroundColor: Colors.green.shade200,
                //padding: const EdgeInsets.all(19),
                tabBorderRadius: 28 ,
                selectedIndex: _index,
                textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                tabs: [
                  GButton(
                    icon: Icons.home_work,
                    text: "Houses",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width*.06,vertical: 20),
                  ),
                  GButton(
                    icon: Icons.monetization_on,
                    text: "Unit Cost",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width*.06,vertical: 20),                  ),
                  GButton(
                    icon: Icons.person_add,
                    text: "Add User",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width*.06,vertical: 20),                  ),
                  GButton(
                    icon: Icons.message_outlined,
                    text: "Complains",
                    textColor: Colors.white,
                    iconActiveColor: Colors.green,
                    iconColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: size.width * .04,vertical: 20),                  ),

                ],
                onTabChange: (index){
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

    );
  }
Widget unitCost(BuildContext context){
  TextEditingController phase1 = TextEditingController();
  TextEditingController phase2 = TextEditingController();
  TextEditingController phase3 = TextEditingController();
  TextEditingController phase4 = TextEditingController();
  TextEditingController phase5 = TextEditingController();
  TextEditingController phase6 = TextEditingController();
  Size size = MediaQuery.of(context).size;
  final labelFontHeight = size.height * 0.06;
  final labelFontWidth = size.width * 0.05;
  final unitPricePhases = <String>{
    "Unit (0 - 50) ",
    "Unit (0 - 75) ",
    "Unit (76 - 100) ",
    "Unit (101 - 200) ",
    "Unit (201 - 300) ",
    "Unit (301 - 400) ",
    "Unit (401 - 600) ",
    "Unit (Above 600)"
  };

  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.black,

    child: ListView.builder(
      itemCount: unitPricePhases.length,
        itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: size.height * 0.08,
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(unitPricePhases.elementAt(index),style: TextStyle(fontWeight: FontWeight.bold),),
              trailing:  Text("0 Tk.",style: TextStyle(fontSize: labelFontWidth),),
              tileColor: Colors.orange.shade600,
              selectedTileColor: Colors.green,
            ),
          ),
        );
        }
    ),
  );
}

  Widget houseView(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green.shade300,

      ),

    );
  }

  Widget addUser(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.shade300,
      ),
    );
  }
  Widget userComplains(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade300,
      ),
    );
  }
  Widget chooseBot(BuildContext context, int pageIndex){
    if(pageIndex==0)return houseView(context);
    if(pageIndex==1) return unitCost(context);
    if(pageIndex==2)return addUser(context);
    else return userComplains(context);

  }
}
