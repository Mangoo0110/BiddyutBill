import 'dart:async';

import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/user_panel/user_dashboard/data_layer.dart/web_pdf_save.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

//import 'web_pdf_save.dart';

class UserPdfBillReciept {
  
  static String titleText = "";
  List<UnitCost> unitCostData;
  MonthlyRecord record;
  String presentMonth;
  UserPdfBillReciept({required this.unitCostData, required this.record, required this.presentMonth});
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

  Future<void> generate() async {
    
    titleText = getTitle(unitCostData);
    final document = Document();

    document.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4.landscape),
      header: (context) {
        return Header(
            decoration: const BoxDecoration(border: null),
            child: buildTitle());
      },
      build: (context) => [
        //buildTitle(),
        Table(
          children: [
            TableRow(children: [
              userDetails(),
              unitCostDetails(),
            ]
            )
          ]
        ),
        // Container(
        //   child: Row(
        //     children: [
        //       Align(
        //         alignment: Alignment.topLeft,
        //         child: userDetails()
        //       ),
        //       Align(
        //         alignment: Alignment.topRight,
        //         child: unitCostDetails()
        //       ),
        //     ]
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: buildRecord(),
        ),
        
      ],
      footer: (context) {
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
    downloadPdf(bytes, "${formatMonthYear(presentMonth)}.pdf");
  }

  static String formatMonthYear(String monthYear) {
    for (int i = 0; i < monthYear.length; i++) {
      if (i == 0) {
        monthYear = monthYear[i].toUpperCase() + monthYear.substring(1);
      }
      if (monthYear[i] == '_') {
        monthYear =
            "${monthYear.substring(0, i)}/${monthYear.substring(i + 1)}";
      }
    }

    return monthYear;
  }

  Widget buildTitle() {
    var monthAndYearText = formatMonthYear(presentMonth);
    return Column(children: [
      Center(
          child: Container(
              child: Text('Patuakhali Science And Technology University',
                  style: const TextStyle(fontSize: 15)))),
      Center(
          child: Container(
              child: Text('Dumki, Patuakhali-8602',
                  style: const TextStyle(fontSize: 15)))),
      
      Center(
          child: Container(
              child: Text('Residensial Electric Bill',
                  style: const TextStyle(fontSize: 15)))),
      SizedBox(height: 5),
      Center(
          child: Container(
              child: Text("Month/Year : $monthAndYearText", style: const TextStyle(fontSize: 11)))),
      SizedBox(height: 5),
    ]);
  }

  Widget buildRecord() {
    final headers = [
      'Current Reading',
      'Previous Reading',
      'Used Unit',
      'Total Tk',
    ];
    //int val =0;
    final data =
        {[
        record.presentmeteRreading,
        record.previousmeterReading,
        record.usedunit,
        record.finaltotalTk
      ]}.toList();

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
      },
      columnWidths: {0: const FlexColumnWidth(2.5),1: const FlexColumnWidth(2.5),2: const FlexColumnWidth(2.5),3: const FlexColumnWidth(2.5)},
    );
  }

  Widget userDetails(){
    return 
     Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text("User Details :",style: TextStyle(color:PdfColors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Divider(
          thickness: 2,
          //color: PdfColor.
          color: PdfColor.fromHex("#ffffff")
        ),
        SizedBox(
          height: 5,
        ),
        Table(
          // columnWidths: const {0:FractionColumnWidth(4),1:FractionColumnWidth(2),
          //                     2:FractionColumnWidth(4)
          //                     },
          children: [
            TableRow(children: [
              text(text: "Name"),
              text(text: " : "),
              text(text: record.fullName),
            ]),
            TableRow(children: [
              text(text: "Occupation"),
              text(text: " : "),
              text(text: record.occupation),
            ]),
            TableRow(children: [
              text(text: "Building name"),
              text(text: " : "),
              text(text: record.buildingName),
            ]),
            TableRow(children: [
              text(text: "House no"),
              text(text: " : "),
              text(text: record.houseNo),
            ]),
          ]
        ),
        //SizedBox(height: 10)
      
      ]
    );
  }
  Widget unitCostDetails(){
    return Column(
      children:[
        Align(
          alignment: Alignment.topLeft,
          child:Text("Per Unit Cost Details :",style: TextStyle(color:PdfColors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Divider(
          thickness: 2,
          color: PdfColor.fromHex("#ffffff")
        ),
        SizedBox(
          height: 5,
        ),
        Table(
          // columnWidths: const {0:FractionColumnWidth(4.0),1:FractionColumnWidth(4.0),
          //                     2:FractionColumnWidth(2.0)
          //                     },
          children: unitCostData.map((data) => 
            TableRow(
              children: [ 
                text(text: "${data.startingRange} - ${data.endingRange}"),
                text(text: " = "),
                text(text: data.rate.toString()),
              ]
            )).toList(),
        ),
        demandchargeAndVatDetails()
      ]
    );
  }
  Widget demandchargeAndVatDetails(){
    return
    Table(
      children: [
        TableRow(children: [
          text(text: "Vat"),
          text(text: " = "),
          text(text: " ${record.vatTk.toString()}%"),
        ]),
        TableRow(children: [
          text(text: "Demand, meter and service charge"),
          text(text: " = "),
          text(text: " ${record.demandchargeTk} Taka per month"),
        ]),
      ]
    );
  }
  Widget text({required String text}){
    return Align(
      alignment: Alignment.topLeft, 
      child: Text(text, style: const TextStyle(color:PdfColors.black, fontSize: 14),maxLines: 6));
  }
}