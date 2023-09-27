
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/pdf_generation.dart';
import 'package:e_bill/admin_panel/new_month_record/domain_layer/riverpod_monthly_record_helper.dart';
import 'package:e_bill/constants/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PDFUI extends ConsumerWidget {
  
  PDFUI({super.key});
  List<MonthlyRecord>allRecordOfThisMonth=[];
  String presentMonthAndYear = "";
  getRequirements(WidgetRef ref){
    
    
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
                  presentMonthAndYear = ref.watch(selectedPresentMonthAndYear);
                  var records = ref.watch(storedRecordsOfMonthProvider);
                  records.when(
                    error: (error, stackTrace) => allRecordOfThisMonth,
                    loading: () => allRecordOfThisMonth,
                    data: (data) {
                      final allUnitCost = ref.watch(allUnitCostProvider);
                      allUnitCost.when(
                        error: (error, stackTrace) => {},
                        loading: () => {},
                        data: (unitCostData) {
                         CreatePdf().generate(allRecordOfThisMonth: data, presentMonth: presentMonthAndYear, unitCostData: unitCostData, type: 1);
                         CreatePdf().generate(allRecordOfThisMonth: data, presentMonth: presentMonthAndYear, unitCostData: unitCostData, type: 2);
                         CreatePdf().generate(allRecordOfThisMonth: data, presentMonth: presentMonthAndYear, unitCostData: unitCostData, type: 3);

                        },
                      );
                      
                      }
                  );
                  
                },
                child:   Row(
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