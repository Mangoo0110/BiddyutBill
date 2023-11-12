
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/pdf_generation.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/riverpod_monthly_record_helper.dart';
import 'package:e_bill/constants/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
typedef DownloadPdfCallback = void Function();
class PDFUI extends StatelessWidget {
  DownloadPdfCallback pdfCallback;
  PDFUI({super.key, required this.pdfCallback});
  List<MonthlyRecord>allRecordOfThisMonth=[];
  String presentMonthAndYear = "";
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  LayoutBuilder(
      builder: (context,constraints)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color:  Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6)),
              child: TextButton(
                onPressed: ()  {
                  pdfCallback();
                },
                child: Row(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.all(3.0),
                      child: Icon(
                          Icons.download,
                          size: 18,
                        ),
                    ),
                      Text("PDF",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsiveNormalButtonFontSize(boxConstraints: constraints),
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
    );
          
}
}