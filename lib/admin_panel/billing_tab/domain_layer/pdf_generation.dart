import 'dart:async';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../unitCostTab/data_layer/unit_cost_model.dart';
import 'mobile_pdf_save.dart' if (dart.library.html) 'web_pdf_save.dart';
import '../data_layer/new_month_record_model.dart';
//import 'web_pdf_save.dart';

class CreatePdf {
  
  static String titleText = "";
  

  String getTitle(List<UnitCost> allUnitCostData) {
    String titleText = "Residential Rate (Per Unit): Tk ";
    // if (allUnitCostData.isEmpty) {
    //   allUnitCostData.add(UnitCost(startingRange: 0, endingRange: 50, rate: 4.35));
    //   allUnitCostData.add(UnitCost(startingRange: 0, endingRange: 75, rate: 4.85));
    //   allUnitCostData.add(UnitCost(startingRange: 76, endingRange: 200, rate: 6.63));
    //   allUnitCostData.add(UnitCost(startingRange: 201, endingRange: 300, rate: 6.95));
    //   allUnitCostData.add(UnitCost(startingRange: 301, endingRange: 400, rate: 7.34));
    //   allUnitCostData.add(UnitCost(startingRange: 401, endingRange: 600, rate: 11.51));
    //   allUnitCostData.add(UnitCost(startingRange: 601, endingRange: 10000, rate: 13.26));
    // }

    for (int i = 0; i < allUnitCostData.length; i++) {
      if(i <allUnitCostData.length-1) {
        titleText ="$titleText${allUnitCostData[i].rate}(${allUnitCostData[i].startingRange}-${allUnitCostData[i].endingRange}), ";
      }
      else { 
        titleText ="$titleText${allUnitCostData[i].rate}(${allUnitCostData[i].startingRange}-Infinity)";
      }
    }
    return titleText;
  }

  Future<void> generate(
    {required List<MonthlyRecord> allRecordOfThisMonth, required String presentMonth,required List<UnitCost>unitCostData,required int type}) async {
    
    titleText = getTitle(unitCostData);
    final document = Document();

    document.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4.landscape),
      header: (context) {
        return Header(
            decoration: const BoxDecoration(border: null),
            child: buildTitle(presentMonth,type));
      },
      build: (context) => [
        //buildTitle(),
        buildRecord(allRecordOfThisMonth: allRecordOfThisMonth, type: type),
      ],      footer: (context) {
        return Column(children: [
          SizedBox(height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Bill Maker/Assistant Engineer(Electricity)',
                style: const TextStyle(fontSize: 11)),
            Text('Executive Engineer(Electricity)',
                style: const TextStyle(fontSize: 11)),
            Text('Executive Engineer(Electricity)',
                style: const TextStyle(fontSize: 11)),
          ]),
          SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('Page ${context.pageNumber} of ${context.pagesCount}'),
          ])
        ]);
      },
    ));

    List<int> bytes = await document.save();
    downloadPdf(bytes, "${formatMonthYear(presentMonth,type)}.pdf");
  }

  static String formatMonthYear(String monthYear,int type) {
    for (int i = 0; i < monthYear.length; i++) {
      if (i == 0) {
        monthYear = monthYear[i].toUpperCase() + monthYear.substring(1);
      }
      if (monthYear[i] == '_') {
        monthYear =
            "${monthYear.substring(0, i)} ${monthYear.substring(i + 1)}";
      }
    }
    if(type==1)monthYear = "$monthYear(Type-A)";
    if(type==2)monthYear = "$monthYear(Type-B)";
    if(type==3)monthYear = "$monthYear(Type-S)";

    return monthYear;
  }

  static Widget buildTitle(String presentMonth,int type) {
    presentMonth = formatMonthYear(presentMonth,type);
    return Column(children: [
      Center(
          child: Container(
              child: Text('$presentMonth Biddut Bill Record',
                  style: const TextStyle(fontSize: 15)))),
      SizedBox(height: 5),
      Center(
          child: Container(
              child: Text(titleText, style: const TextStyle(fontSize: 11)))),
      SizedBox(height: 5),
    ]);
  }

  static Widget buildRecord({required List<MonthlyRecord> allRecordOfThisMonth, required int type}) {
    
    // for (int i = 0; i < 50; i++) {
    //   allRecordOfThisMonth.add(MonthlyRecord(
    //       varsityid: '0$i',
    //       fullName: 'Mr$i',
    //       occupation: 'student',
    //       accountNo: "345325",
    //       buildingName: 'House',
    //       houseNo: "$i",
    //       meterNo: '123',
    //       presentmeteRreading: 12.3,
    //       previousmeterReading: 2.3,
    //       usedunit: 12,
    //       unitcostTk: 24,
    //       demandchargeTk: 35,
    //       firsttotalTk: 12.3,
    //       vatTk: 5,
    //       secondtotalTk: 212.3,
    //       finaltotalTk: 212));
    // }
    final headers = [
      'Name',
      'Occupation',
      'Address',
      'Previous Reading',
      'Current Reading',
      'Cost',
      'Demand',
      'Total',
      'Vat(%)',
      'Total',
      'Final Total',
    ];
    //int val =0;
    print("len.... ${allRecordOfThisMonth.length}");
    final data = allRecordOfThisMonth.map((item) { 
      print("${item.fullName}... typeA ${item.typeA} typeB ${item.typeB} typeS ${item.typeS}");
      if((type == 1 && item.typeA==true) || (type == 2 && item.typeB==true) || (type==3 && item.typeS  == true)){
      return [
        item.fullName,
        item.occupation,
        "${item.buildingName}/${item.houseNo}",
        item.previousmeterReading,
        item.presentmeteRreading,
        item.unitcostTk,
        item.demandchargeTk,
        item.firsttotalTk,
        item.vatTk,
        item.secondtotalTk,
        item.finaltotalTk
      ];
      }
      else {
        return [
        ];
      }
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      //border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      headerAlignment: Alignment.topCenter,
      //cellHeight: 15,
      cellStyle: const TextStyle(fontSize: 10),
      cellAlignments: {
        0: Alignment.topLeft,
        1: Alignment.topLeft,
        2: Alignment.topLeft,
        3: Alignment.topCenter,
        4: Alignment.topCenter,
        5: Alignment.topCenter,
        6: Alignment.topCenter,
        7: Alignment.topCenter,
        8: Alignment.topCenter,
        9: Alignment.topCenter,
        10: Alignment.topCenter,
      },
      columnWidths: {0: const FlexColumnWidth(2),1: const FlexColumnWidth(2),2: const FlexColumnWidth(1),3: const FlexColumnWidth(1),4: const FlexColumnWidth(1),
                      5: const FlexColumnWidth(1),6: const FlexColumnWidth(1),7: const FlexColumnWidth(1),8: const FlexColumnWidth(1),9: const FlexColumnWidth(1),
                      10: const FlexColumnWidth(1)},
    );
  }
}