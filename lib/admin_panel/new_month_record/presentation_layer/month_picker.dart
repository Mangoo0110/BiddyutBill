import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedMonthCallback = void Function(String pickedPreviousMonthAndYear,String pickedPresentMonthAndYear);
class MonthPickerUI extends StatelessWidget {
  String monthAndYear = "";
  SelectedMonthCallback onDone;
  MonthPickerUI({
    Key? key,
    required this.monthAndYear,
    required this.onDone,
    }): super(key: key);


    int _selectedIndex = 0;
    String presentMonthAndYear = "";
    String previousMonthAndYear = "";
    List<String> allMonthYears= [];
    List<String> allMonths=[
      "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ];
    
    getAllMonthYears(){
      // List<String> allMonths = [];
      // for(int index = 1; index<=12; index++){
      // DateTime dateTime = DateTime(2023,index);
      // allMonths.add(dateTime.month.toString());
      //}
      presentMonthAndYear = monthAndYear;
      for(int index = 2010; index<=DateTime.now().year; index++){
      DateTime dateTime = DateTime(index);
      if(index!=DateTime.now().year){
      for(int indexM = 0; indexM<allMonths.length; indexM++){
        var month = allMonths[indexM];
        var year = dateTime.year.toString();
        allMonthYears.add("$month $year");
      }
      }
      else{
        for(int indexM = 0; indexM<DateTime.now().month; indexM++){
        var month = allMonths[indexM];
        var year = dateTime.year.toString();
        allMonthYears.add("$month $year");
      }
      }
    }
    }

  // List<Widget> monthYearWidgetList(){
  //     getAllMonthYears();
  //     List<Widget>widgetList = [];
  //     for(int index = 0; index<=allMonthYears.length; index++){
  //       widgetList.add(
  //         Text(allMonthYears[index],style:const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),)
  //       );
  //     }
  //     return widgetList;
  //   }
    
    int indexOfIntialdate(){
    
      for(int index = 0; index<allMonthYears.length; index++){
        var splitter = allMonthYears[index].split(' ');
        var tiedString = splitter[0].toLowerCase() + '_' + splitter[1];
        if(tiedString==presentMonthAndYear){
          
          _selectedIndex = index;
          return index;
        }
      }
      return 0;
    }
    String removeSpaceFromString(String str){
      var splitter = str.split(' ');
        var tiedString = splitter[0].toLowerCase() + "_" + splitter[1].toLowerCase();
        return tiedString;
    }
  @override
  Widget build(BuildContext context) {
    getAllMonthYears();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: AlertDialog(
        backgroundColor: Colors.white,
        actionsAlignment: MainAxisAlignment.end,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(4),
          ),
            child: TextButton(
            onPressed: (){
              presentMonthAndYear = removeSpaceFromString(allMonthYears[_selectedIndex]);
              previousMonthAndYear = removeSpaceFromString(allMonthYears[(_selectedIndex==0? 0: _selectedIndex-1)]);
              onDone(previousMonthAndYear,presentMonthAndYear);
            }, child: const Text("Done",style: TextStyle(color: Colors.black,fontSize: 17),)),
          ),
        )
      ],
       content: SizedBox(
        height: size.height * .2,
        width: size.width * .4,
         child: CupertinoPicker(
          backgroundColor: Colors.white,
          itemExtent: 50,
          scrollController: FixedExtentScrollController(
            initialItem: indexOfIntialdate(),
          ),
          children:  allMonthYears.map((item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item,style: TextStyle(color: Colors.green),),
          )).toList(),
          onSelectedItemChanged: (int index) {
            _selectedIndex = index;
            var splitted =  allMonthYears[index].split(' ');
            monthAndYear = splitted[0] + splitted[1];
          },
         ),
       ),
      ),
    );
  }
}