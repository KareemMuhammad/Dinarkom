import 'dart:convert';
import 'package:dinarkom/model/winners_model.dart';
import 'package:dinarkom/service/winners_service.dart';
import 'package:http/http.dart';

class WinnersRepo{
final WinnersService _winnersService = WinnersService();

Future<List<WinnersModel>> loadWinners()async{
  Response response = await _winnersService.fetchWinners();
  if(response.statusCode == 200){
    List list = jsonDecode(response.body)['winners'];
    return list.map((e) => WinnersModel.fromJson(e)).toList();
  }else{
    return [];
  }
}
}