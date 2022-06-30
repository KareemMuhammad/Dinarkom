import 'package:dinarkom/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/shared.dart';

class VerificationScreen extends StatelessWidget {
  final bool? canResend;
  const VerificationScreen({Key? key, this.canResend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.3,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: greyOpacity,
                      borderRadius: const BorderRadius.only(topLeft:
                      Radius.circular(60),topRight: Radius.circular(60)),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('${Utils.getTranslatedText(context,'verify_text')}'
                                ,style: TextStyle(color: white,fontSize: SizeConfig.blockSizeVertical! * 2.8,)
                                ,textAlign: TextAlign.center,),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical! * 4,),
                            GestureDetector(
                              onTap: ()async{
                                await Future.delayed(const Duration(seconds: 5));
                                sendEmailVerification(context);
                              } ,
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: greyOpacity
                                ),
                                child:  Center(
                                  child: Text("${Utils.getTranslatedText(context,'resend_text')}",
                                    style: TextStyle(color: white,
                                        fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeVertical! * 2.5),),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.transparent
                                ),
                                child: Center(
                                  child: Text("${Utils.getTranslatedText(context,'cancel_text')}",
                                    style: const TextStyle(color: white,
                                        fontWeight: FontWeight.bold,fontSize: 18),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void sendEmailVerification(BuildContext context) async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }catch(e){
      Utils.showSnack('', e.toString(), context, greyOpacity);
    }
  }
}
