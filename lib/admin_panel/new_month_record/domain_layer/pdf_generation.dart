import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'mobile_pdf_save.dart' if (dart.library.html) 'web_pdf_save.dart';
import '../data_layer/new_month_record_model.dart';
//import 'web_pdf_save.dart';

class CreatePdf {
  Future<void> generate(
      List<MonthlyRecord> allRecordOfThisMonth, String presentMonth) async {
    final document = Document();

    document.addPage(MultiPage(
      pageTheme: PageTheme(pageFormat: PdfPageFormat.a4.landscape),
      header: (context) {
        return Header(
            decoration: const BoxDecoration(border: null),
            child: buildTitle(presentMonth));
      },
      build: (context) => [
        //buildTitle(),
        buildRecord(allRecordOfThisMonth),
      ],
      footer: (context) {
        return Footer(
          trailing: buildFooter(context),
        );
      },
    ));

    List<int> bytes = await document.save();
    downloadPdf(bytes, "Current_Month_Record.pdf");
  }

  static String formatMonthYear(String monthYear) {
    for (int i = 0; i < monthYear.length; i++) {
      if (i == 0) {
        monthYear = monthYear[i].toUpperCase() + monthYear.substring(1);
      }
      if (monthYear[i] == '_') {
        monthYear =
            "${monthYear.substring(0, i)} ${monthYear.substring(i + 1)}";
      }
    }
    return monthYear;
  }

  static Widget buildTitle(String presentMonth) {
    presentMonth = formatMonthYear(presentMonth);
    return Column(children: [
      Center(
          child: Container(
              child: Text('Patuakhali Science And Technology University',
                  style: const TextStyle(fontSize: 25)))),
      SizedBox(height: 5),
      Center(
          child: Container(
              child: Text('$presentMonth Biddut Bill Record',
                  style: const TextStyle(fontSize: 15)))),
      SizedBox(height: 10),
    ]);
  }

  static Widget buildRecord(List<MonthlyRecord> allRecordOfThisMonth) {
    
    for (int i = 0; i < 50; i++) {
      allRecordOfThisMonth.add(MonthlyRecord(
          varsityid: '0$i',
          fullName: 'Mr$i',
          occupation: 'student',
          accountNo: "345325",
          buildingName: 'House',
          houseNo: "$i",
          meterNo: '123',
          presentmeteRreading: 12.3,
          previousmeterReading: 2.3,
          usedunit: 12,
          unitcostTk: 24,
          demandchargeTk: 35,
          firsttotalTk: 12.3,
          vatTk: 5,
          secondtotalTk: 212.3,
          finaltotalTk: 212));
    }
    final headers = [
      'Name',
      'Addres',
      'Curr Reading',
      'Prev Reading',
      'Cost',
      'Demand',
      'Total',
      'Vat(%)',
      'Total',
      'Final Total',
    ];

    final data = allRecordOfThisMonth.map((item) {
      return [
        item.fullName,
        item.buildingName,
        item.houseNo,
        item.presentmeteRreading,
        item.previousmeterReading,
        item.unitcostTk,
        item.demandchargeTk,
        item.firsttotalTk,
        item.vatTk,
        item.secondtotalTk,
        item.finaltotalTk
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      //cellHeight: 15,
      cellStyle: const TextStyle(fontSize: 12),
      cellAlignments: {
        0: Alignment.topLeft,
        1: Alignment.topLeft,
        2: Alignment.topCenter,
        3: Alignment.topCenter,
        4: Alignment.topCenter,
        5: Alignment.topCenter,
        6: Alignment.topCenter,
        7: Alignment.topCenter,
        8: Alignment.topCenter,
        9: Alignment.topCenter,
        10: Alignment.centerRight,
      },
      columnWidths: {0: const FlexColumnWidth(1), 1: const FlexColumnWidth(2)},
    );
  }

  static Widget buildFooter(context) {
    return Row(children: [
      Text('Page ${context.pageNumber} of ${context.pagesCount}'),
    ]);
  }
}