import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_crud.dart';
import 'package:e_bill/admin_panel/unitCostTab/data_layer/unit_cost_model.dart';

Future<List<UnitCost>>getAllUnitCost() async{
   List<UnitCost> allUnitCost = await UnitCostStorage().fetchAllUnitCost();
   return allUnitCost;
   }