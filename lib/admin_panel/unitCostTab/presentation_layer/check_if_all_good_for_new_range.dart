import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';

bool checkIfAllGood({
  required List<UnitCost> allUnitCost,
  required UnitCost newUnitCostRange
}){
  int length = allUnitCost.length;
  for (int index = 0; index < length; index++){
    if(!(allUnitCost[index].startingRange > newUnitCostRange.endingRange || allUnitCost[index].endingRange < newUnitCostRange.startingRange) || (newUnitCostRange.startingRange >= newUnitCostRange.endingRange)){
      return false;
    }
  }
  print("truuuuue");
  return true;
}