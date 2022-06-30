import 'package:another_flushbar/flushbar.dart';
import 'package:dinarkom/model/ads_model.dart';
import 'package:dinarkom/model/digital_photo_model.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;
enum ScreenSize { small, medium, large }

class Utils{
  /////////////////////////////////////////////////////////////// constants //////////////////////////////////////////////////////////////

  static const List<String> mySwiper = ['assets/ikea_logo.png','assets/download.png'];
  static const DigitalPhoto dummyDigitalPhoto = DigitalPhoto.dummy(id: 0, smallPaidImage: '',
       totalCount: 150, totalSales: 100, expire: 0, imagePrice: 1);
  // static const AppUser dummyUser = AppUser.dummy(id: '', nationalID: '',
  //     name: '', email: '', phone: '', anotherPhone: '', position: false);
  static const String assetsUtil = 'https://www.dinarkoom.com/landAssest/images/images/';

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);



static const double _breakPoint1 = 600.0;
static const double _breakPoint2 = 840.0;

  static ScreenSize getScreenSize(double width) {
    if (width < _breakPoint1) {
      return ScreenSize.small;
    } else if (width >= _breakPoint1 && width <= _breakPoint2) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }

  static Future<bool> isLoggedIn()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     final String? token = prefs.getString('authToken');
     if(token != null && token.isNotEmpty){
       return true;
     }else{
       return false;
     }
  }

  static Future<String> currentToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    if(token != null && token.isNotEmpty){
      return token;
    }else{
      return '';
    }
  }


static String? getTranslatedText(BuildContext context,String key){
    return AppLocale.of(context).getTranslated(key);
  }

  static String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '۵', '٦', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }

  static showSnack(String text,String title,BuildContext context,Color color)async{
    await Flushbar(
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      messageText:Text(text,style: const TextStyle(color: white,fontFamily: '',fontSize: 17),),
      titleText: Text(title,style: const TextStyle(color: white,fontFamily: '',
              fontSize: 17,fontWeight: FontWeight.w300),),
      backgroundColor: color,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(FontAwesomeIcons.info,color: white,),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static int dateDifference(String date,String time){
    return DateTime(int.parse(date.split('-')[0]),int.parse(date.split('-')[1],)
        ,int.parse(date.split('-')[2]),int.parse(time.split(':')[0]),
        int.parse(time.split(':')[1]),int.parse(time.split(':')[2])).millisecondsSinceEpoch;
  }

}

class Translations {
  static final languages = <String>[
    'English',
    'عربى',
    'أوردو',
    'Filipino',
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'عربى':
        return 'ar';
      case 'أوردو':
        return 'ur';
      case 'Filipino':
        return 'fil';
      default:
        return 'en';
    }
  }

  static String getLanguageFromCode(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'عربى';
      case 'ur':
        return 'أوردو';
      case 'fil':
        return 'Filipino';
      default:
        return 'en';
    }
  }
}
