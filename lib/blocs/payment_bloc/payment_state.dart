import 'package:dinarkom/model/payment_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState{}

class LoadingPayment extends PaymentState{}

class PaymentSuccessful extends PaymentState{
  final PaymentModel paymentModel;

  PaymentSuccessful(this.paymentModel);
}

class PaymentFailed extends PaymentState{
  final String message;

  PaymentFailed(this.message);
}