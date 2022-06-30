import 'dart:convert';

import 'package:dinarkom/service/user_service.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import '../../widgets/helpers/shared_widgets.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController emailController =  TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  CircleAvatar(
                      backgroundColor: white,
                      radius: 50,
                      child: Image.asset('assets/empty_logo.png',fit: BoxFit.cover,)),
                  const SizedBox(height: 5,),
                  const Text('Dinarkom',style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 35),),
                  Text('${Utils.getTranslatedText(context,'welcome')}',style: const TextStyle(color: white,fontSize: 19),),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: greyOpacity,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('${Utils.getTranslatedText(context,'forget_password_hint')}'
                                  ,style: const TextStyle(color: white,fontSize: 17,),textAlign: TextAlign.center,),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: emailController,
                                  style: const TextStyle(color: white),
                                  decoration: textInputDecorationSign('${Utils.getTranslatedText(context,'email')}', Icons.email_outlined,),
                                ),
                              ),
                              const SizedBox(height: 40,),
                             show?
                             GestureDetector(
                                onTap: ()async{
                                  setState(() {
                                    show = false;
                                  });
                                 var response = await UserHttpService().resetPasswordService(emailController.text);
                                 Utils.showSnack('', '${jsonDecode(response.body)['message']}', context, black);
                                 debugPrint(jsonDecode(response.body).toString());
                                  setState(() {
                                    show = true;
                                    emailController.clear();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey[600]
                                  ),
                                  child:  Center(
                                    child: Text("${Utils.getTranslatedText(context,'send_link')}",
                                      style: const TextStyle(color: white, fontWeight: FontWeight.bold,fontSize: 18),),
                                  ),
                                ),
                              ) : loading(),
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
                                      color: white
                                  ),
                                  child:  Center(
                                    child: Text("${Utils.getTranslatedText(context,'back')}",
                                      style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold,fontSize: 18),),
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
            ),
        ),
    );
  }
}
