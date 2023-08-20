import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';

class MonthlyRecord{
final String varsityid ;
final String fullName;
final String houseAddress ;
final String meterno ;
 double presentmeteRreading;
 double previousmeterReading;
 double usedunit;
 double unitcostTk;
final double demandchargeTk ;
 double firsttotalTk;
final double vatTk;
 double secondtotalTk;
 double finaltotalTk;

  MonthlyRecord({required this.varsityid, required this.fullName, required this.houseAddress,required this.meterno,required this.presentmeteRreading,
  required this.previousmeterReading,required this.usedunit, required this.unitcostTk,required this.demandchargeTk, 
  required this.firsttotalTk,required this.vatTk,required this.secondtotalTk,required this.finaltotalTk});

  factory MonthlyRecord.fromJson(Map<String,dynamic>json){
    print("monthly hi...");
    return MonthlyRecord(
      varsityid: json[varsityId],
      fullName: json[name],
      houseAddress: json[houseAddresS],
      meterno: json[meterNo],
      presentmeteRreading: double.parse(json[presentMeterReading]) ,
      previousmeterReading: double.parse(json[previousMeterReading]),
      usedunit:  double.parse(json[unitCostTk]),
      unitcostTk: double.parse(json[unitCostTk]),
      demandchargeTk: double.parse(json[demandChargeTk]),
      firsttotalTk: double.parse(json[firstTotalTk]),
      vatTk: double.parse(json[vat]),
      secondtotalTk: double.parse(json[secondTotalTk]),
      finaltotalTk: double.parse(json[finalTotalTk]),
      );
       }
}