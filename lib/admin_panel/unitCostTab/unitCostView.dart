import 'package:flutter/material.dart';

class UnitCostView extends StatefulWidget {
  const UnitCostView({super.key});

  @override
  State<UnitCostView> createState() => _UnitCostViewState();
}

class _UnitCostViewState extends State<UnitCostView> {
  @override
  Widget build(BuildContext context){
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
                height: 80,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(unitPricePhases.elementAt(index),style: const TextStyle(fontWeight: FontWeight.bold),),
                  trailing: const Text("0 Tk.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                  tileColor: Colors.green.shade400,
                  selectedTileColor: Colors.green,
                ),
              ),
            );
          }
      ),
    );
  }
}
