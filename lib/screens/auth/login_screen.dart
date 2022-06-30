import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import '../../widgets/auth/login_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              const SizedBox(height: 20,),
              CircleAvatar(
                  backgroundColor: white,
                  radius: 50,
                  child: Hero(
                      tag: 'logoTag',
                      child: Image.asset('assets/empty_logo.png',fit: BoxFit.cover,))),
              const SizedBox(height: 5,),
              const Text('Dinarkoom',style: TextStyle(color: white,
                fontWeight: FontWeight.bold,fontSize: 35,),),
              Text('${Utils.getTranslatedText(context,'welcome')}',
                style: const TextStyle(color: white,fontSize: 19),),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration:  BoxDecoration(
                    color: greyOpacity,
                    borderRadius: const BorderRadius.only(topLeft:
                    Radius.circular(60),topRight: Radius.circular(60)),
                  ),
                  child: const SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.all(30),
                      child:  LoginWidget()
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
