import 'package:dinarkom/utils/language_delegate.dart';
import 'package:dinarkom/widgets/helpers/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/shared.dart';

Widget customAppBar(BuildContext context){
  return AppBar(
      backgroundColor: dark,
      elevation: 2,
      centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 6, 2),
      child: Image.asset("assets/logo.png",fit: BoxFit.cover,height: 70,width: 70,),
    ),
  );
}

ThemeData englishTheme(){
  return ThemeData(
      primaryColor: Colors.grey,
      fontFamily: 'Cairo-Medium',
      scaffoldBackgroundColor: black,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
              color: white
          )
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: white),
        headline6: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic,color: white),
        bodyText2: TextStyle(fontSize: 16.0,color: white),
      ),
      unselectedWidgetColor: Colors.white
  );
}

Widget photoShimmer(BuildContext context){
  return MyShimmer.rectangular(
      height: AppLocale.of(context).currentCode == 'ar' ||
          AppLocale.of(context).currentCode == 'ur'?
      SizeConfig.screenHeight! * 0.2
          : SizeConfig.screenHeight! * 0.19,
      width: SizeConfig.screenWidth! * 0.37);
}

Widget adsShimmer(BuildContext context){
  return MyShimmer.rectangular(
    height: AppLocale.of(context).currentCode == 'ar' ||
        AppLocale.of(context).currentCode == 'ur'?
    SizeConfig.screenHeight! * 0.12 : SizeConfig.screenHeight! * 0.12,
    width: SizeConfig.screenWidth!,);
}

Widget loading(){
  return const SpinKitPulse(color: Colors.white70,size: 70,);
}

Widget circleLoading(){
  return SpinKitPulse(color: white,size: SizeConfig.screenWidth! * 0.6,);
}

InputDecoration textInputDecorationSign(String hintText,IconData iconData){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide:  BorderSide(color: greyOpacity, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide:  BorderSide(color: greyOpacity, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: greyOpacity, width: 2.0),
    ),
    hintText: hintText,
    counterStyle: const TextStyle(color: white,fontSize: 14),
    helperStyle: const TextStyle(color: white,fontSize: 14),
    hintStyle: const TextStyle(color: white,fontSize: 14),
    border: InputBorder.none,
    suffixIcon: Icon(iconData,color: Colors.grey[600],)
  );
}

InputDecoration textInputDecorationSign2(String hintText){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide:  BorderSide(color: greyOpacity, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide:  BorderSide(color: greyOpacity, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: greyOpacity, width: 2.0),
    ),
    hintText: hintText,
    counterStyle: const TextStyle(color: white,fontSize: 14),
    helperStyle: const TextStyle(color: white,fontSize: 14),
    hintStyle: const TextStyle(color: white,fontSize: 14),
    border: InputBorder.none,
  );
}




