import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';

class SizeConfig {
  static MediaQueryData ?_mediaQueryData;
  static double ?screenWidth;
  static double ?screenHeight;
  static double ?blockSizeHorizontal;
  static double ?blockSizeVertical;
  static double ?_safeAreaHorizontal;
  static double ?_safeAreaVertical;
  static double ?safeBlockHorizontal;
  static double ?safeBlockVertical;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth!/100;
    blockSizeVertical = screenHeight!/100;
    _safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!)/100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!)/100;
  }
}

Color dark = HexColor('#0866ac');
Color light = HexColor('#3bc2f1');
Color gold = HexColor('#D4AF37');
Color greyOpacity = Colors.grey.withOpacity(0.5);

const Color white = Colors.white;
const Color black = Colors.black;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
const appLink = "https://play.google.com/store/apps/details?id=com.outofthebox.dinarkom";

const storage =  FlutterSecureStorage();