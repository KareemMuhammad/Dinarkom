import 'package:dinarkom/service/base_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DigitalPhotoService extends BaseAPI{
  Future<Response> getDigitalPhoto()async{
    try {
      Response response = await get(Uri.parse(super.digitalPhotoPath));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
}