import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_constant.dart';

class MonthlyRecord{
final String assignedUserID;
final String fullName;
final String occupation;
final String accountNo;
final String buildingName;
final String houseNo;
final String meterNo ;
 double presentmeteRreading;
 double previousmeterReading;
 double usedunit;
 double unitcostTk;
final double demandchargeTk ;
 double firsttotalTk;
final double vatTk;
 double secondtotalTk;
 double finaltotalTk;
 bool typeA;
 bool typeB;
 bool typeS;

  MonthlyRecord({required this.assignedUserID, required this.fullName, required this.occupation, required this.accountNo, required this.buildingName,required this.houseNo, required this.meterNo,required this.presentmeteRreading,
  required this.previousmeterReading,required this.usedunit, required this.unitcostTk,required this.demandchargeTk, 
  required this.firsttotalTk,required this.vatTk,required this.secondtotalTk,required this.finaltotalTk, required this.typeA, required this.typeB, required this.typeS});

  factory MonthlyRecord.fromJson(Map<String,dynamic>json){
    return MonthlyRecord(
      assignedUserID: json[varsityId],
      fullName: json[name],
      occupation: json[occupatioN],
      accountNo: json[accountno],
      buildingName: json[buildingname],
      houseNo: json[houseno],
      meterNo: json[meterno],
      presentmeteRreading: double.parse(json[presentMeterReading]) ,
      previousmeterReading: double.parse(json[previousMeterReading]),
      usedunit:  double.parse(json[unitCostTk]),
      unitcostTk: double.parse(json[unitCostTk]),
      demandchargeTk: double.parse(json[demandChargeTk]),
      firsttotalTk: double.parse(json[firstTotalTk]),
      vatTk: double.parse(json[vat]),
      secondtotalTk: double.parse(json[secondTotalTk]),
      finaltotalTk: double.parse(json[finalTotalTk]),
      typeA: json[aType]=="0"?false:true,
      typeB: json[bType]=="0"?false:true ,
      typeS: json[sType]=="0"?false:true ,
      );
       }
}