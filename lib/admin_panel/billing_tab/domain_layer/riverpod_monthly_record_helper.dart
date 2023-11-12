import 'dart:js_interop';

import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_constant.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_crud.dart';
import 'package:e_bill/admin_panel/billing_tab/data_layer/new_month_record_model.dart';
import 'package:e_bill/admin_panel/billing_tab/domain_layer/generate_record_key.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_cruds.dart';
import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';
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
    List<House> allHouses = [];
    List<House> filteredHouses = [];
    MonthlyRecord? presentRecord;
    MonthlyRecord? previousRecord;
    allUsers = await UserStorage().fetchAllUsers();
    allHouses = await HouseStorage().fetchAllHouses();
    for(int index = 0; index<allHouses.length; index++){
      var house = allHouses[index];
      if (house.meterNo.toString() != "" && house.meterNo.toString().toLowerCase() != "null") {
          filteredHouses.add(house);       
      }
    }
    for(int index=0; index<filteredHouses.length;index++){
      var house = filteredHouses[index];
      User? user;
      String userName ="";
      String userId = "";
      String userOccupation = "";
      String userAccountNo = "";
      bool typeA = true;
      bool typeS = false;
      bool typeB = false;
      if(house.assignedUserID!=""){
        user = await UserStorage().fetchOneUser(varsityId: house.assignedUserID);
        if(user!=null){
          userId = user.id;
          userName = user.fullName;
          userOccupation = user.occupation;
          userAccountNo = user.accountNo;
          typeA = user.typeA;
          typeB = user.typeB;
          typeS = user.typeS;
        }
      }
      presentRecord = await MonthlyRecordStorage().fetchARecordForHouse(monthYear: presentMonthAndYear, house: house);
      if(presentRecord.isNull){
        var dvx = demandChargeAndVatPercentage[0];
        for(int it = 0; it < demandChargeAndVatPercentage.length; it++){
          if(typeA == demandChargeAndVatPercentage[it].typeA && typeB == demandChargeAndVatPercentage[it].typeB && typeS == demandChargeAndVatPercentage[it].typeS){
            dvx = demandChargeAndVatPercentage[it];
          }
        }
        MonthlyRecord filledRecord = MonthlyRecord(
                                      assignedUserID: userId, fullName: userName, occupation: userOccupation,buildingName: house.buildingName,
                                      houseNo: house.houseNo, meterNo: house.meterNo,accountNo: userAccountNo, presentmeteRreading: 0, previousmeterReading: 0,
                                      usedunit: 0, unitcostTk: 0, demandchargeTk: dvx.demandChargeTk, firsttotalTk: 0,
                                      vatTk: dvx.vatPercentageTk, secondtotalTk: 0, finaltotalTk: 0,typeA: typeA, typeB: typeB, typeS: typeS);
                                      
        presentRecord = filledRecord;
      }
      if(presentRecord!=null){
        if (presentRecord.previousmeterReading==0){
          previousRecord = await MonthlyRecordStorage().fetchARecordForHouse(monthYear: previousMonthAndYear, house: house);
          if (previousRecord!=null){
          presentRecord.previousmeterReading = previousRecord.presentmeteRreading;
          }
        }
        allRecordOfThisMonth.add(presentRecord);
        if (readyToPush[presentRecord.assignedUserID]==null) readyToPush[generateRecordKey(presentRecord)] = false;
      }
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



final storedRecordsOfMonthProvider = FutureProvider((ref) async{
 if(ref.watch(newRecordPush)==true){
  var records =  await MonthlyRecordStorage().fetchAllRecord(monthYear: ref.watch(selectedPresentMonthAndYear));
  ref.read(newRecordPush.notifier).update((state) => false);
  return records;
 }
 else{
  var records =  await MonthlyRecordStorage().fetchAllRecord(monthYear: ref.watch(selectedPresentMonthAndYear));
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