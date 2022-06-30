import 'dart:convert';
import 'package:dinarkom/model/payment_model.dart';
import 'package:dinarkom/model/payment_response_model.dart';
import 'package:dinarkom/model/purchase_model.dart';
import 'package:dinarkom/service/payment_service.dart';
import 'package:http/http.dart';

class PaymentRepo{
  final PaymentService _paymentService = PaymentService();

  Future<PaymentResponseModel> checkPayment(String token)async{
   Response response = await _paymentService.checkPayService(token);
   if(response.statusCode == 200){
     if(jsonDecode(response.body)['data'] != null) {
       return PaymentResponseModel(
         message: jsonDecode(response.body)['message'],
       paymentModel: PaymentModel.fromJson(jsonDecode(response.body)));
     }else{
       return PaymentResponseModel(
           message: jsonDecode(response.body)['message'],
           paymentModel: PaymentModel());
     }
   }else {
     return PaymentResponseModel(message: 'Error from server',
         paymentModel: PaymentModel());
   }
  }

  Future<String> payResponse(String token)async{
    Response response = await _paymentService.payService(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['status'] != false) {
        return jsonDecode(response.body)['url'];
      }else{
        return '';
      }
    }else {
      return 'Error from server';
    }
  }

  Future<PurchaseModel> getMyPurchases(String token)async{
    Response response = await _paymentService.getPurchase(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['purches'] != null) {
        return PurchaseModel.fromJson(jsonDecode(response.body));
      }else{
        return PurchaseModel(status: false,errorNumber: '',message: '',purchase: []);
      }
    }else{
      return PurchaseModel(status: false,errorNumber: '',message: '',purchase: []);
    }
  }
}