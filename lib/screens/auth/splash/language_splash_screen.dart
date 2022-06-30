import 'package:delayed_display/delayed_display.dart';
import 'package:dinarkom/screens/auth/choose_language_screen.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';

class LanguageSplashScreen extends StatefulWidget {
  const LanguageSplashScreen({Key? key}) : super(key: key);

  @override
  _LanguageSplashScreenState createState() => _LanguageSplashScreenState();
}

class _LanguageSplashScreenState extends State<LanguageSplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3),
            () =>  Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ChooseLanguage()))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedDisplay(
                fadeIn: true,
                delay: const Duration(seconds: 1),
                child: CircleAvatar(
                    backgroundColor: white,
                    radius: 90,
                    child: Image.asset('assets/empty_logo.png',fit: BoxFit.cover,)),
              ),
              const SizedBox(height: 10,),
              const DelayedDisplay(
                  fadeIn: true,
                  delay: Duration(seconds: 2),
                  child: Text('Dinarkoom',style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 45),)),
            ],
          ),
      ),
    );
  }
}