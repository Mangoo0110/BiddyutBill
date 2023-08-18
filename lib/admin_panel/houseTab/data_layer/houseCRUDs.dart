
import 'dart:convert';

import 'package:e_bill/admin_panel/houseTab/data_layer/houseModel.dart';
import 'package:e_bill/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class HouseStorage{

  List<House>housesFromJson(String jsonString){
    final data = json.decode(jsonString);
    //print(data);
    return List<House>.from(
        data.map((item) =>House.fromJson(item))
    );
  }

  Future<List<House>>fetchAllHouses()async{
      var result = await http.post(
        Uri.parse(API.fetchAllHouses),
      );
      if(result.statusCode == 200){
        //print(result.body);
        List<House> list = housesFromJson(result.body);
        return list;
      }
      else {
        return <House>[];
      }

}


}