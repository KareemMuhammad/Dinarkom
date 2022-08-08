import 'package:dinarkom/blocs/payment_bloc/payment_cubit.dart';
import 'package:dinarkom/model/payment_model.dart';
import 'package:dinarkom/widgets/dialogs/terms_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../screens/nav_screens/knet_screen.dart';
import '../../utils/constants.dart';
import '../../utils/shared.dart';

class ChoosePaymentUser extends StatefulWidget {
  final List<Data> users;
  final PaymentCubit paymentCubit;
  final String token;
  const ChoosePaymentUser({Key? key, required this.users,
    required this.paymentCubit, required this.token}) : super(key: key);

  @override
  _ChoosePaymentUserState createState() => _ChoosePaymentUserState();
}

class _ChoosePaymentUserState extends State<ChoosePaymentUser> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.9,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          widget.users.isNotEmpty?
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: white,
              ),

              Flexible(
                child: Text('${Utils.getTranslatedText(context,'payment')}',
                  style: const TextStyle(color: white,fontSize: 19,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
              ),
            ],
          ) : const SizedBox(),
          const SizedBox(height: 40,),
        widget.users.isNotEmpty?
        Expanded(
            child: ListView.builder(
              itemCount: widget.users.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                    value: index + 1,
                    groupValue: selectedIndex,
                    title: Text(widget.users[index].name!,style: const
                    TextStyle(
                        fontSize: 17,
                        color: white,
                        fontWeight: FontWeight.bold
                    ),),
                    activeColor: light,
                    onChanged: (value){
                      setState(() {
                        selectedIndex = index + 1;
                      });
                    });
              },
            ),
          ) : Center(child: Text('${Utils.getTranslatedText(context,'error_buy')}')),

          widget.users.isEmpty?  const SizedBox(height: 50,) : const SizedBox(),

          ElevatedButton(
            onPressed: () async{
              if(widget.users.isNotEmpty) {
                dynamic result = await showDialog(
                    context: context,
                    builder: (_) =>
                        Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            backgroundColor: greyOpacity,
                            child: const TermsDialog()));
                if (result == 'pay') {
                  String url = await widget.paymentCubit.pay(widget.token,
                      widget.users[selectedIndex - 1].id!);
                  if(url.contains('http')){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          child: KeyNetScreen(
                              url: widget.paymentCubit.knetUrl)),);
                  }
                }
              }else{
                Navigator.pop(context);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.users.isNotEmpty?
              '${Utils.getTranslatedText(context,'validate_invoice')}'
                : '${Utils.getTranslatedText(context,'back')}',
                style:  TextStyle(fontSize: 18,color: Colors.grey[700],fontWeight: FontWeight.bold),),
            ),

          ),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
