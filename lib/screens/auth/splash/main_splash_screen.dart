import 'package:delayed_display/delayed_display.dart';
import 'package:dinarkom/screens/main_screen.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
     Future.delayed(
        const Duration(seconds: 3),
            () =>  Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MainScreen()))
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
