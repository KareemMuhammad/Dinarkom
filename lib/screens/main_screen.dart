import 'dart:ui';
import 'package:dinarkom/blocs/bar_bloc/bar_cubit.dart';
import 'package:dinarkom/blocs/bar_bloc/bar_state.dart';
import 'package:dinarkom/blocs/language_bloc/locale_cubit.dart';
import 'package:dinarkom/screens/bar_screens/winners_screen.dart';
import 'package:dinarkom/screens/nav_screens/about_us_screen.dart';
import 'package:dinarkom/screens/nav_screens/contact_screen.dart';
import 'package:dinarkom/screens/nav_screens/purchases_screen.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../blocs/login_bloc/login_cubit.dart';
import '../blocs/login_bloc/login_state.dart';
import '../widgets/dialogs/second_language_sheet.dart';
import 'auth/login_screen.dart';
import 'bar_screens/home_screen.dart';
import 'bar_screens/account_screen.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController myPage = PageController(initialPage: 2);
    final BarCubit barCubit = BlocProvider.of<BarCubit>(context);
    final LocaleCubit langCubit = BlocProvider.of<LocaleCubit>(context);
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    SizeConfig().init(context);
    return BlocBuilder<BarCubit,BarState>(
        builder: (BuildContext context, state) {
        return Container(
          decoration: state.index < 2 ? const BoxDecoration(
            color: black
          ) :  const BoxDecoration(
                image: DecorationImage(
                image: AssetImage('assets/flame.gif') ,
                fit: BoxFit.cover,
             )
          ) ,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: _customDrawer(langCubit,barCubit,myPage,loginCubit),
            body: Stack(
              children: [
                     PageView(
                              controller: myPage,
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
                                ContactScreen(),
                                AccountScreen(),
                                HomeScreen(),
                              ],
                            ),
                openCustomDrawerIcon(),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(page: myPage,)
          ),
        );
      }
    );
  }

  Widget _customDrawer(LocaleCubit localeCubit,BarCubit barCubit,
      PageController myPage,LoginCubit loginCubit){
    return SafeArea(
      child: BlocBuilder<LoginCubit,LoginState>(
        builder: (context,state) {
          return Drawer(
              elevation: 2,
              backgroundColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    closingCustomDrawerIcon(),
                    SizedBox(height: SizeConfig.screenHeight! * 0.01,),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.faceSmile,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title: Text(
                          state is LoginSuccessful?
                          '${Utils.getTranslatedText(context,'welcome')?.split(' ')[0]}  ${state.appUser.name}':
                          loginCubit.currentUser != null ?
                          '${Utils.getTranslatedText(context,'welcome')?.split(' ')[0]} ${loginCubit.currentUser!.name ?? 'Guest'}'
                          : '${Utils.getTranslatedText(context,'welcome')?.split(' ')[0]} Guest',
                                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 2.1,
                                    fontFamily: 'Qadishia',
                                    color: white,)
                              ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),

                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(FontAwesomeIcons.houseChimney,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title: Text('${Utils.getTranslatedText(context,'home')}',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                        color: white,
                        fontFamily: 'Qadishia',
                      ),),
                      onTap: (){
                        Navigator.pop(context);
                        myPage.jumpToPage(2);
                        barCubit.index = 2;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(FontAwesomeIcons.userLarge,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title: Text('${Utils.getTranslatedText(context,'account')}',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                        color: white,
                        fontFamily: 'Qadishia',
                      ),),
                      onTap: (){
                        Navigator.pop(context);
                        myPage.jumpToPage(1);
                        barCubit.index = 1;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(FontAwesomeIcons.envelopeOpenText,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title: Text('${Utils.getTranslatedText(context,'contact')}',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                          color: white,
                          fontFamily: 'Qadishia',
                        ),),
                      onTap: (){
                        Navigator.pop(context);
                        myPage.jumpToPage(0);
                        barCubit.index = 0;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(FontAwesomeIcons.wallet,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title: Text(Utils.getTranslatedText(context,'winners')!.split(' ')[0],
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                        color: white,
                        fontFamily: 'Qadishia',
                      ),),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType
                                  .leftToRight,
                              duration: const Duration(
                                  milliseconds: 300),
                              child: const WinnersScreen()),);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(Icons.shopping_bag_outlined,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title:  Text('${Utils.getTranslatedText(context,'orders')}',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 2.1,
                          fontFamily: 'Qadishia',
                          color: white,
                        ),),
                      onTap: (){
                        if(loginCubit.currentUser != null) {
                          Navigator.pop(context);
                          Navigator.push(context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                                child: PurchasesScreen(
                                  token: loginCubit.currentUser!.token ??
                                      '',),));
                        }else{
                          Navigator.pushReplacement(context,
                            PageTransition(
                                type: PageTransitionType
                                    .rightToLeft,
                                duration: const Duration(
                                    milliseconds: 300),
                                child: const LoginScreen()),);
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    BlocBuilder<LocaleCubit,LocaleState>(
                        builder: (context,state) {
                          return GestureDetector(
                            onTap: (){
                              _showMySheet(context, state.locale.languageCode, localeCubit);
                            },
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                              leading: Icon(Icons.language,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                              title:  Text('${Utils.getTranslatedText(context,'language')}',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 2.1,
                                  fontFamily: 'Qadishia',
                                  color: white,
                                ),),
                            ),
                          );
                        }
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child:  Divider(height: 1,color: white,),
                    ),
                    ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios,color: white,size: 19,),
                      leading: Icon(FontAwesomeIcons.info,size: SizeConfig.blockSizeVertical! * 2.2,color: white,),
                      title:  Text('${Utils.getTranslatedText(context,'about')}',
                        style:  TextStyle(
                        fontSize: SizeConfig.blockSizeVertical! * 2.1,
                        fontFamily: 'Qadishia',
                        color: white,
                      ),),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400),
                              child: AboutUsScreen(code: AppLocale.of(context).currentCode,),));
                      },
                    ),

                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                          radius: SizeConfig.blockSizeVertical! * 2.8,
                          backgroundColor: white,
                          child: Image.asset('assets/empty_logo.png',height: SizeConfig.blockSizeVertical! * 10,
                            width: SizeConfig.blockSizeVertical! * 10,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Text('${Utils.getTranslatedText(context,'follow_us')}',
                        style: TextStyle(color: white,
                            fontSize: SizeConfig.blockSizeVertical! * 2.3,
                            fontWeight: FontWeight.bold),),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.whatsapp),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: white,),
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.email),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: white,),
                        IconButton(
                          onPressed: (){

                          }, icon: const Icon(Icons.facebook),
                          iconSize: SizeConfig.blockSizeVertical! * 3,color: white,),
                      ],
                    ),
                     SizedBox(height: SizeConfig.blockSizeVertical! * 1.5,),
                  ],
                ),
              ),
          );
        }
      ),
    );
  }

  void _showMySheet(BuildContext context,String code,LocaleCubit langCubit) {
    showModalBottomSheet(context: context, builder: (_){
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: LanguageSheet(langCode: code,langCubit: langCubit,));
    },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
    );
  }

  Widget openCustomDrawerIcon(){
    return BlocBuilder<LocaleCubit,LocaleState>(
        builder: (context,state) {
        return SafeArea(
          child: Align(
                alignment: state.locale.languageCode == 'en' || state.locale.languageCode == 'fil'?
                Alignment.topLeft : Alignment.topRight,
                child: Builder(
                  builder: (context) =>
                     Padding(
                       padding: state.locale.languageCode == 'en' || state.locale.languageCode == 'fil'?
                       const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                       child: GestureDetector(
                         onTap: (){
                           Scaffold.of(context).openDrawer();
                         },
                         child: Image.asset('assets/options.png',
                           height: SizeConfig.blockSizeVertical! * 5,
                           width: SizeConfig.blockSizeVertical! * 5,),
                       ),
                     )
                ),
              ),
        );
      }
    );
  }

  Widget closingCustomDrawerIcon(){
    return BlocBuilder<LocaleCubit,LocaleState>(
        builder: (context,state) {
          return SafeArea(
            child: Align(
              alignment: state.locale.languageCode == 'en' || state.locale.languageCode == 'fil'?
              Alignment.topLeft : Alignment.topRight,
              child: Builder(
                  builder: (context) =>
                      Row(
                        children: [
                          Padding(
                            padding: state.locale.languageCode == 'en' || state.locale.languageCode == 'fil'?
                            const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Image.asset('assets/options.png',
                                height: SizeConfig.blockSizeVertical! * 4,
                                width: SizeConfig.blockSizeVertical! * 4,),
                            ),
                          ),
                        ],
                      )
              ),
            ),
          );
        }
    );
  }
}
