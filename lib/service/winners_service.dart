import 'dart:convert';

import 'package:dinarkom/service/base_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class WinnersService extends BaseAPI{
  Future<Response> fetchWinners()async{
    try {
      Response response = await get(Uri.parse(super.winnersPath));
      debugPrint(jsonDecode(response.body).toString());
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
}