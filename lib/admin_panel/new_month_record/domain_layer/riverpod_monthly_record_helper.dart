import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/new_month_record/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_cruds.dart';
import 'package:e_bill/admin_panel/usersTab/data_layer/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final selectedPresentMonthAndYear = StateProvider<String>((ref){
  final List<String> allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return "${allMonths[DateTime.now().month - 1].toLowerCase()}_${DateTime.now().year.toString()}";
});

final selectedPreviousMonthAndYear = StateProvider<String>((ref){
  final List<String> allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
int prvYear = DateTime.now().year;
      if(DateTime.now().month == 1){
        prvYear = prvYear - 1;
        return "${allMonths[11].toLowerCase()}_${prvYear.toString()}";
      } 
      else{
        return
        "${allMonths[DateTime.now().month - 2].toLowerCase()}_${DateTime.now().year.toString()}";
      }
});


final demandChargeAndVatPercentageState = FutureProvider<List<DemandChargeVatPercentage>>((ref) async{
 return await DemandChargeVatPercentageStorage().fetchDemandChargeVatPercentageStorage();
});


final monthlyRecordProvider = FutureProvider<List<MonthlyRecord>>((ref) async{
    var presentMonthAndYear = ref.watch(selectedPresentMonthAndYear);
    var previousMonthAndYear = ref.watch(selectedPreviousMonthAndYear);
    Map<String,bool>readyToPush = ref.watch(readyToPushProvider);
    var demandChargeAndVatPercentage = await DemandChargeVatPercentageStorage().fetchDemandChargeVatPercentageStorage();
    List<MonthlyRecord> allRecordOfThisMonth=[];
    List<User> allUsers = [];
    List<User> filteredUser = [];
    List<MonthlyRecord> presentRecord=[];
    List<MonthlyRecord> previousRecord=[];
    allUsers = await UserStorage().fetchAllUsers();
    
    for(int index = 0; index<allUsers.length; index++){
      var user = allUsers[index];
      if (user.meteNo.toString() != "" && user.meteNo.toString().toLowerCase() != "null") {
          filteredUser.add(user);       
      }
    }
    for(int index=0; index<filteredUser.length;index++){
      var user = filteredUser[index];
      presentRecord = await MonthRecordStorage().fetchRecord(monthYear: presentMonthAndYear, varsityid: user.varsityId);
      if(presentRecord.isEmpty)
      {
       var dvx = demandChargeAndVatPercentage[0];
       MonthlyRecord filledRecord = MonthlyRecord(
      varsityid: user.varsityId, fullName: user.fullName, occupation: user.occupation,buildingName: user.buildingName,
      houseNo: user.houseNo, meterNo: user.meteNo,accountNo: user.accountNo, presentmeteRreading: 0, previousmeterReading: 0,
      usedunit: 0, unitcostTk: 0, demandchargeTk: dvx.demandChargeTk, firsttotalTk: 0,
      vatTk: dvx.vatPercentageTk, secondtotalTk: 0, finaltotalTk: 0,typeA: user.typeA, typeB: user.typeB, typeS: user.typeS);
       presentRecord.add(filledRecord);
      }
      
        if(presentRecord[0].previousmeterReading==0){
          previousRecord = await MonthRecordStorage().fetchRecord(monthYear: previousMonthAndYear, varsityid: user.varsityId);
          if(previousRecord.isNotEmpty){
          presentRecord[0].previousmeterReading = previousRecord[0].presentmeteRreading;
          }
        }
      allRecordOfThisMonth.add(presentRecord[0]);
      if(readyToPush[presentRecord[0].varsityid]==null)readyToPush[presentRecord[0].varsityid] = false;
      
      
    }
    ref.read(recordsToBePushProvider.notifier).update((state) => allRecordOfThisMonth);
    ref.read(readyToPushProvider.notifier).update((state) => readyToPush);
    return allRecordOfThisMonth;
});


final searchedMonthlyRecordsProvider = FutureProvider<List<MonthlyRecord>>((ref) async{
  final List<MonthlyRecord>searchedRecords = [];
  final searchText = ref.watch(searchedRecordText);
  var _data =  ref.watch(monthlyRecordProvider);
  _data.when(
    data:(allRecordOfThisMonth) {
      for (int index = 0; index < allRecordOfThisMonth.length; index++) {
      //print("index");
      //print(searchText);
      
      if (allRecordOfThisMonth[index].fullName.toLowerCase().contains(searchText.toLowerCase())) {
        var userType = ref.watch(selectedUserType);/// selected type of user from billing section ui
      if(userType.toLowerCase() == "all"){
       searchedRecords.add(allRecordOfThisMonth[index]);
      }
      else if(userType.toLowerCase() == aType.toLowerCase() && allRecordOfThisMonth[index].typeA==true){
        searchedRecords.add(allRecordOfThisMonth[index]);
      }
      else if(userType.toLowerCase() == bType.toLowerCase() && allRecordOfThisMonth[index].typeB==true){
        searchedRecords.add(allRecordOfThisMonth[index]);
      }
      else if(userType.toLowerCase() == sType.toLowerCase() && allRecordOfThisMonth[index].typeS==true){
        searchedRecords.add(allRecordOfThisMonth[index]);
      }
        
      }
    }
    return searchedRecords;
    }, 
    error:(error, stackTrace) {
      
    }, 
    loading: (){});
    return searchedRecords;
});

//   final pushallRecordsProvider = FutureProvider((ref) async{
//     print("pushing");
//   List<MonthlyRecord>failedToSend = [];
//   List<MonthlyRecord>records = ref.read(recordsToBePushProvider);
//   final readyToPush = ref.read(readyToPushProvider);
//   String monthAndYear = ref.read(selectedPresentMonthAndYear);
//   for(int index =0;index<records.length; index++){
//     print(readyToPush[records[index].varsityid]);
//   if(readyToPush[records[index].varsityid]==true){
//     readyToPush[records[index].varsityid] = false;
//    var success =  await MonthRecordStorage().pushMonthlyRecord(monthYear: monthAndYear, record: records[index]);
//   if(!success){
//     failedToSend.add(records[index]);
//       }
//     }
//   }
//   var date = ref.read(selectedPresentMonthAndYear);
//   ref.read(selectedPresentMonthAndYear.notifier).update((state) => ref.read(selectedPreviousMonthAndYear));
//   ref.read(selectedPresentMonthAndYear.notifier).update((state) => date);
//   ref.watch(failedToPush.notifier).update((state) => failedToSend);
// });

final storedRecordsOfMonthProvider = FutureProvider((ref) async{
 if(ref.watch(newRecordPush)==true){
  var records =  await MonthRecordStorage().fetchAllRecord(monthYear: ref.watch(selectedPresentMonthAndYear));
  ref.read(newRecordPush.notifier).update((state) => false);
  return records;
 }
 else{
  var records =  await MonthRecordStorage().fetchAllRecord(monthYear: ref.watch(selectedPresentMonthAndYear));
  ref.read(newRecordPush.notifier).update((state) => false);
  return records;
 }

});

final allUnitCostProvider = FutureProvider<List<UnitCost>>((ref) async{
  return await UnitCostStorage().fetchAllUnitCost();
});
final newRecordPush = StateProvider((ref) => false);
final failedToPush = StateProvider<List<MonthlyRecord>>((ref) => []);
final recordsToBePushProvider = StateProvider<List<MonthlyRecord>>((ref) => []);
final searchedRecordText = StateProvider<String>((ref) => "");
final readyToPushProvider = StateProvider<Map<String,bool>>((ref) => {});
final recordOfUserId = StateProvider<String>((ref) => "");
final recordMonthYearDate = StateProvider<String>((ref) => ref.read(selectedPresentMonthAndYear));
final selectedUserType = StateProvider<String>((ref) => "All");