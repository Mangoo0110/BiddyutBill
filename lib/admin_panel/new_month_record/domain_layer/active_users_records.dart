import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';

Future<MonthlyRecord> fillEmptyRecords({ required User user, required List<DemandChargeVatPercentage> demandChargeAndVatPercentage})async{ 
    DemandChargeVatPercentage dvx = demandChargeAndVatPercentage[0];
    MonthlyRecord filledRecord = MonthlyRecord(
      varsityid: user.varsityId, fullName: user.fullName, occupation: user.occupation,buildingName: user.buildingName,
      houseNo: user.houseNo, meterNo: user.meteNo,accountNo: user.accountNo, presentmeteRreading: 0, previousmeterReading: 0,
      usedunit: 0, unitcostTk: 0, demandchargeTk: dvx.demandChargeTk, firsttotalTk: 0,
      vatTk: dvx.vatPercentageTk, secondtotalTk: 0, finaltotalTk: 0);

      return filledRecord;
   }

Future<List<MonthlyRecord>> getAllActiveUserRecords({required previousMonthAndYear,required String presentMonthAndYear, required List<DemandChargeVatPercentage> demandChargeAndVatPercentage}) async {
   
    List<MonthlyRecord> allRecordOfThisMonth=[];
    List<User> allUsers = [];
    List<User> filteredUser = [];
    List<MonthlyRecord> presentRecord=[];
    List<MonthlyRecord> previousRecord=[];
    allUsers = await UserStorage().fetchAllUsers();
    print("hi..");
    for(int index = 0; index<allUsers.length; index++){
      var user = allUsers[index];
      if (user.meteNo.toString() != "") {
          filteredUser.add(user);       
      }
    }
    for(int index=0; index<filteredUser.length;index++){
      var user = filteredUser[index];
      presentRecord = await MonthRecordStorage().fetchRecord(monthYear: presentMonthAndYear, varsityid: user.varsityId);
      if(presentRecord.isEmpty)
      {
       final filledRecord = await fillEmptyRecords(user: user, demandChargeAndVatPercentage: demandChargeAndVatPercentage);
       presentRecord.add(filledRecord);
      }
      
        if(presentRecord[0].previousmeterReading.toInt()==0){
          previousRecord = await MonthRecordStorage().fetchRecord(monthYear: previousMonthAndYear, varsityid: user.varsityId);
          if(previousRecord.isNotEmpty){
          presentRecord[0].previousmeterReading = previousRecord[0].presentmeteRreading;
          }
        }
      
      //print("printing... "+ previousRecord[0].presentmeteRreading.toString());
      allRecordOfThisMonth.add(presentRecord[0]);
    }
    print("hi...");
    return allRecordOfThisMonth;
  }