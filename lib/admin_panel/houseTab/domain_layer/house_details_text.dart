import 'package:e_bill/admin_panel/houseTab/data_layer/house_model.dart';

List<String>houseDetailsText({
  required House house
}){
  List<String>detailText= [];
  detailText.add("Building Name : ${house.buildingName}");
  detailText.add("House No : ${house.houseNo}");
  detailText.add("Meter No : ${house.meterNo}");
  detailText.add("User ID : ${house.assignedUserID}");
  return detailText;
}