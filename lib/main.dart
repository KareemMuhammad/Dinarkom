import 'package:dinarkom/blocs/about_bloc/about_cubit.dart';
import 'package:dinarkom/blocs/ads_bloc/ads_cubit.dart';
import 'package:dinarkom/blocs/bar_bloc/bar_cubit.dart';
import 'package:dinarkom/blocs/digital_photo_bloc/digital_photo_cubit.dart';
import 'package:dinarkom/blocs/language_bloc/locale_cubit.dart';
import 'package:dinarkom/blocs/login_bloc/login_cubit.dart';
import 'package:dinarkom/blocs/payment_bloc/payment_cubit.dart';
import 'package:dinarkom/blocs/register_bloc/register_cubit.dart';
import 'package:dinarkom/blocs/winners_bloc/winners_cubit.dart';
import 'package:dinarkom/repositories/ads_repo.dart';
import 'package:dinarkom/repositories/digital_photo_repo.dart';
import 'package:dinarkom/repositories/payment_repo.dart';
import 'package:dinarkom/repositories/user_repo.dart';
import 'package:dinarkom/repositories/winners_repo.dart';
import 'package:dinarkom/screens/auth/splash/language_splash_screen.dart';
import 'package:dinarkom/screens/auth/splash/main_splash_screen.dart';
import 'package:dinarkom/service/about_service.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/verification_bloc/verify_cubit.dart';
import 'widgets/helpers/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? langCode;
String? userToken;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  langCode = prefs.getString('lang');
  userToken = prefs.getString('authToken');
  runApp(
    const MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BarCubit(),
        ),
        BlocProvider(
          create: (context) => VerifyCubit(),
        ),
        BlocProvider(
          create: (context) => AboutCubit(aboutService: AboutService()),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getStartLang(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(userRepository: UserRepository())..getCurrentUser(userToken ?? ''),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) => AdsCubit(adsRepo: AdsRepo()),
        ),
        BlocProvider(
          create: (context) => DigitalCubit(digitalPhotoRepo: DigitalPhotoRepo()),
        ),
        BlocProvider(
          create: (context) => WinnersCubit(winnersRepo: WinnersRepo()),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(paymentRepo: PaymentRepo()),
        ),
      ],
      child: BlocBuilder<LocaleCubit,LocaleState>(
          buildWhen: (previousState, currentState) => previousState != currentState,
        builder: (context,state) {
           return MaterialApp(
             debugShowCheckedModeBanner: false,
             theme: englishTheme(),
             supportedLocales: const[
               Locale('en'),
               Locale('ar'),
               Locale('ur'),
               Locale('fil'),
             ],
             localizationsDelegates: const[
               AppLocale.delegate,
               GlobalMaterialLocalizations.delegate,
               GlobalCupertinoLocalizations.delegate,
               GlobalWidgetsLocalizations.delegate,
             ],
             locale: state.locale,
             localeResolutionCallback: (Locale? locale,
                 Iterable<Locale> supportedLocales,) {
               if (locale != null) {
                 for (Locale myLocal in supportedLocales) {
                   if (myLocal.countryCode == locale.countryCode) {
                     return locale;
                   }
                 }
               }
               return supportedLocales.first;
             },
             home: langCode == null ?
             const LanguageSplashScreen() : const MainSplashScreen(),
           );
         }
      ),
    );
  }
}
