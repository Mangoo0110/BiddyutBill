import 'package:e_bill/admin_panel/new_month_record/domain_layer/riverpod_monthly_record_helper.dart';
import 'package:e_bill/admin_panel/new_month_record/presentation_layer/new_month_record_view.dart';
import 'package:e_bill/constants/responsive_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SelectedMonthCallback = void Function();
class MonthPickerUI extends ConsumerWidget {
  SelectedMonthCallback onDone;
  SelectedMonthCallback onCancel;
  MonthPickerUI({
    Key? key,
    required this.onDone,
    required this.onCancel,
    }): super(key: key);


    int _selectedIndex = 0;
    String presentMonthAndYear = "";
    String previousMonthAndYear = "";
    List<String> allMonthYears= [];
    List<String> allMonths=[
      "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ];
    
    getAllMonthYears(WidgetRef ref){
      presentMonthAndYear = ref.read(selectedPresentMonthAndYear);
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

    updateSelectedDates(WidgetRef ref){
      ref.read(selectedPresentMonthAndYear.notifier).update((state) => presentMonthAndYear);
      ref.read(selectedPreviousMonthAndYear.notifier).update((state) => previousMonthAndYear);
      ref.read(readyToPushProvider.notifier).update((state) => {});
    }
    
    int indexOfIntialdate(){
    
      for(int index = 0; index<allMonthYears.length; index++){
        var splitter = allMonthYears[index].split(' ');
        var tiedString = "${splitter[0].toLowerCase()}_${splitter[1]}";
        if(tiedString==presentMonthAndYear){   
          _selectedIndex = index;
          return index;
        }
      }
      return 0;
    }
    String removeSpaceAddUnderScore(String str){
      var splitter = str.split(' ');
        var tiedString = splitter[0].toLowerCase() + "_" + splitter[1].toLowerCase();
        return tiedString;
    }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    getAllMonthYears(ref);
    return LayoutBuilder(
      builder: (context,constraints)=> Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6)),
                             child: InkWell(
                              onTap: () {
                                      Navigator.of(context).push(PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        reverseTransitionDuration:
                                            const Duration(milliseconds: 500),
                                        pageBuilder: (context, b, e) {
                                          return mmyyyyDialogBox(context,ref);
                                        },
                                      ));
                                    },
                              child:  Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.date_range,
                                     // size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                   Padding(
                                     padding: EdgeInsets.all(5.0),
                                     child: Text(
                                          "Pick a date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints),),
                                        ),
                                   )
                                ],
                              ),
                            )),
                      ),
    );
                   
  }
  Widget mmyyyyDialogBox(BuildContext context,WidgetRef ref){
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
            color: Colors.black12,
            borderRadius: BorderRadius.circular(4),
          ),
            child: TextButton(
            onPressed: (){
              onCancel();
            }, child: const Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 17),)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(4),
          ),
            child: TextButton(
            onPressed: (){
              presentMonthAndYear = removeSpaceAddUnderScore(allMonthYears[_selectedIndex]);
              previousMonthAndYear = removeSpaceAddUnderScore(allMonthYears[(_selectedIndex==0? 0: _selectedIndex-1)]);
              updateSelectedDates(ref);
              onDone();
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
            //monthAndYear = splitted[0] + splitted[1];
          },
         ),
       ),
      ),
    );
  
  }
}