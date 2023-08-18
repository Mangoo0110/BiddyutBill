import 'package:e_bill/admin_panel/unitCostTab/data_layer/crud_demand_charge_vat_percentage.dart';
import 'dart:async';

import 'package:e_bill/admin_panel/unitCostTab/data_layer/demand_charge_vat_percentage.dart';
Future<List<DemandChargeVatPercentage>>getDemandChargeAndVatPercentage() async{
   List<DemandChargeVatPercentage> demandChargeAndVatPercentage = await DemandChargeVatPercentageStorage().fetchDemandChargeVatPercentageStorage();
    return demandChargeAndVatPercentage;
   }