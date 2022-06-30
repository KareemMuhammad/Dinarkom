import 'package:dinarkom/blocs/payment_bloc/payment_state.dart';
import 'package:dinarkom/model/payment_model.dart';
import 'package:dinarkom/model/payment_response_model.dart';
import 'package:dinarkom/repositories/payment_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState>{
  final PaymentRepo? paymentRepo;
  PaymentCubit({this.paymentRepo}) : super(PaymentInitial());

  PaymentModel? _paymentModel;
  String? knetUrl;

  PaymentModel get getPaymentCheck => _paymentModel!;

  Future checkUserPayment(String token)async{
    debugPrint(token);
    emit(LoadingPayment());
     PaymentResponseModel res = await paymentRepo!.checkPayment(token);
     if(res.paymentModel!.data != null){
       debugPrint('payment = ${res.paymentModel}');
       _paymentModel = res.paymentModel;

       //  knetUrl = await pay(token, _paymentModel!.data!.first.id!);
       emit(PaymentSuccessful(_paymentModel!));
     }else{
       emit(PaymentFailed(res.message!));
     }
  }

  Future<String> pay(String token,int relativeId)async{
     knetUrl = await paymentRepo!.payResponse(token);
     if(knetUrl!.isEmpty){
       return 'You Cannot buy this photo again!';
     }else{
       return knetUrl!;
     }
  }

}