import 'package:dinarkom/model/payment_model.dart';

class PaymentResponseModel{
  final String? message;
  final PaymentModel? paymentModel;

  PaymentResponseModel({this.message, this.paymentModel});

}