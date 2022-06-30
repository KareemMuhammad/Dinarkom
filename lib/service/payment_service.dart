import 'dart:convert';

import 'package:dinarkom/service/base_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class PaymentService extends BaseAPI{

  Future<Response> payService(String token)async{
    try {

      Response response = await post(Uri.parse(super.paymentPath +
          'auth_token=$token&'),
          headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> checkPayService(String token)async{
    try {

      Response response = await post(Uri.parse(super.paymentCheckPath +
          'auth_token=$token&'),
          headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getPurchase(String token)async{
    try {

      Response response = await post(Uri.parse(super.purchase +
          'auth_token=$token'),
          headers: super.headers);
      debugPrint(jsonDecode(response.body).toString());
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }
}