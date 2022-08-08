import 'dart:ui';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dinarkom/blocs/ads_bloc/ads_cubit.dart';
import 'package:dinarkom/blocs/bar_bloc/bar_cubit.dart';
import 'package:dinarkom/blocs/digital_photo_bloc/digital_photo_cubit.dart';
import 'package:dinarkom/blocs/digital_photo_bloc/digital_photo_state.dart';
import 'package:dinarkom/blocs/payment_bloc/payment_cubit.dart';
import 'package:dinarkom/blocs/payment_bloc/payment_state.dart';
import 'package:dinarkom/screens/auth/login_screen.dart';
import 'package:dinarkom/screens/nav_screens/knet_screen.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/helpers/large_screen_image.dart';
import 'package:dinarkom/widgets/helpers/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../blocs/ads_bloc/ads_state.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../widgets/dialogs/choose_payment_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? _currentMonth;

  final Shader linearGradient = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors:  <Color>[ Colors.grey, Colors.white,],
  ).createShader(
      Rect.fromCircle(
        center: const Offset(10, -200),
        radius: 30 / 3,
      )
  );

   late LoginCubit loginCubit;
   late PaymentCubit paymentCubit;

  @override
  void initState() {
    loginCubit = BlocProvider.of<LoginCubit>(context);
    paymentCubit = BlocProvider.of<PaymentCubit>(context);
    BlocProvider.of<DigitalCubit>(context).getCurrentDigitalInfo();
    BlocProvider.of<AdsCubit>(context).getAdsModel();
    BlocProvider.of<BarCubit>(context).index = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _currentMonth = DateFormat('MMMM yyyy', AppLocale.of(context).currentCode)
        .format(DateTime.now()).toUpperCase().toString();
    return SafeArea(
      child: Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeVertical! * 0,
                0,SizeConfig.blockSizeVertical! * 0,SizeConfig.blockSizeVertical! * 1),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppLocale.of(context).currentCode == 'ar' ||
                      AppLocale.of(context).currentCode == 'ur'?
                  SizedBox(height: SizeConfig.blockSizeVertical! * 6,) :
                  SizedBox(height: SizeConfig.blockSizeVertical! * 6,),

                  BlocBuilder<DigitalCubit,DigitalPhotoState>(
                    builder: (context,state) {
                      return state is DigitalLoaded ?
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.blockSizeVertical! * 1,
                                SizeConfig.blockSizeVertical! * 4,
                                SizeConfig.blockSizeVertical! * 1,
                                SizeConfig.blockSizeVertical! * 4),
                            child: _counterWidget(context,state.digitalPhoto!.totalCount!),
                          ),

                          Utils.getScreenSize(SizeConfig.screenWidth!) != ScreenSize.small?
                          SizedBox(height: SizeConfig.blockSizeVertical! * 8,) : const SizedBox(),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                            child: Card(
                              elevation: 90,
                              color: Colors.transparent,
                              child: SizedBox(
                                height: SizeConfig.screenHeight! * 0.26,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [

                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 2.2,),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,
                                                PageTransition(
                                                    type: PageTransitionType.bottomToTop,
                                                    duration: const Duration(milliseconds: 300),
                                                    child: LargeScreenImage(
                                                      image: state.digitalPhoto!.smallPaidImage!,
                                                    )),);
                                            },
                                            child: Card(
                                              elevation: 90,
                                              color: greyOpacity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: state.digitalPhoto!.smallPaidImage!,
                                                  height: AppLocale.of(context).currentCode == 'ar' ||
                                                      AppLocale.of(context).currentCode == 'ur'?
                                                  SizeConfig.screenHeight! * 0.2
                                                      : SizeConfig.screenHeight! * 0.19,
                                                  width: SizeConfig.screenWidth! * 0.37,fit: BoxFit.fitHeight,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Column(
                                        children:  [
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 2.2,),
                                          Flexible(
                                            child: Text('${Utils.getTranslatedText(context,'digital_photo')}',
                                              style: TextStyle(fontSize:
                                                  AppLocale.of(context).currentCode == 'fil'?
                                                  SizeConfig.blockSizeVertical! * 2.1:
                                                  SizeConfig.blockSizeVertical! * 2.3,
                                                  color: white,fontWeight: FontWeight.bold,letterSpacing: 1,
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.8),
                                                      offset: const Offset(3.0, 3.0),
                                                    ),
                                                  ],
                                                  fontFamily: 'Sequel Sans'),textAlign: TextAlign.center,),
                                          ),
                                          AppLocale.of(context).currentCode == 'ar' ||
                                              AppLocale.of(context).currentCode == 'ur'?
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 0.4,):
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 1.2,),
                                          Text(_currentMonth!,style: TextStyle(
                                              fontSize: SizeConfig.blockSizeVertical! * 2.1,
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.8),
                                                  offset: const Offset(3.0, 3.0),
                                                ),
                                              ],
                                              fontFamily: 'Sequel Sans'),),
                                          AppLocale.of(context).currentCode == 'ar' ||
                                              AppLocale.of(context).currentCode == 'ur'?
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 0.6,):
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
                                          Text('${state.digitalPhoto!.imagePrice!}KD',
                                            style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 3.9,
                                                fontFamily: 'Impact',
                                                color: white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                                          AppLocale.of(context).currentCode == 'ar' ||
                                              AppLocale.of(context).currentCode == 'ur'?
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 1,):
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 1.2,),
                                          BlocConsumer<PaymentCubit,PaymentState>(
                                            listener: (context,state)async{
                                              if(state is PaymentSuccessful) {
                                               await showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) {
                                                    return BackdropFilter(
                                                        filter: ImageFilter
                                                            .blur(sigmaX: 40, sigmaY: 40),
                                                        child: ChoosePaymentUser(
                                                          token: loginCubit
                                                              .currentToken!,
                                                          users: state
                                                              .paymentModel.data!,
                                                          paymentCubit: paymentCubit,
                                                        ));
                                                  },
                                                  backgroundColor: Colors.transparent,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .only(topRight: Radius
                                                          .circular(30),
                                                          topLeft: Radius
                                                              .circular(30))
                                                  ),
                                                );

                                              }
                                              },
                                            builder: (context,state) {
                                              return  state is LoadingPayment?
                                               Center(child: SpinKitSquareCircle(
                                                 color: greyOpacity,size: 20,))
                                              :GestureDetector(
                                                onTap: ()async{
                                                    if(loginCubit.currentUser!.id != null) {
                                                      if(loginCubit.getToken.isNotEmpty
                                                      && loginCubit.getToken.isNotEmpty) {
                                                        await paymentCubit.checkUserPayment(
                                                            loginCubit.getToken);
                                                      }else{
                                                        Navigator.pushReplacement(context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              duration: const Duration(
                                                                  milliseconds: 400),
                                                              child: const LoginScreen()),);
                                                      }
                                                    }else {
                                                      Navigator.pushReplacement(context,
                                                        PageTransition(
                                                            type: PageTransitionType
                                                                .rightToLeft,
                                                            duration: const Duration(
                                                                milliseconds: 400),
                                                            child: const LoginScreen()),);
                                                    }

                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(25.0),
                                                      color: white,
                                                      gradient: const LinearGradient(
                                                        begin: Alignment.topRight,
                                                        end: Alignment.bottomLeft,
                                                        colors: [
                                                          Colors.white70,
                                                          Colors.white,
                                                        ],
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.8),
                                                          offset: const Offset(5.0, 5.0),
                                                          blurRadius: 15,
                                                        ),
                                                      ]
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical! * 4,
                                                        vertical:    AppLocale.of(context).currentCode == 'ar' ||
                                                            AppLocale.of(context).currentCode == 'ur'?
                                                        SizeConfig.blockSizeVertical! * 0.8:
                                                        SizeConfig.blockSizeVertical! * 0.9),
                                                    child: Text('${Utils.getTranslatedText(context,'buy')}',
                                                      style:  TextStyle(fontSize: SizeConfig.blockSizeVertical! * 1.8,
                                                        color: Colors.grey[700],
                                                        fontWeight: FontWeight.bold,

                                                      ),),
                                                  ),
                                                ),
                                              );
                                            }
                                          ),
                                          AppLocale.of(context).currentCode == 'ar' ||
                                              AppLocale.of(context).currentCode == 'ur'?
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 0.5,):
                                          SizedBox(height: SizeConfig.blockSizeVertical! * 1.2,),
                                          Expanded(
                                            child: Text('${Utils.getTranslatedText(context,'sales')} ${state.digitalPhoto!.totalSales!}',
                                              style: TextStyle(fontSize: AppLocale.of(context).currentCode == 'ar' ||
                                                  AppLocale.of(context).currentCode == 'ur'?
                                                   SizeConfig.blockSizeVertical! * 1.9
                                                  :SizeConfig.blockSizeVertical! * 2.1, color: white,
                                                fontFamily: 'Sequel Sans',
                                                shadows: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.8),
                                                    offset: const Offset(3.0, 3.0),
                                                  ),
                                                ],),
                                              textAlign: TextAlign.center,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ):
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: waitingWidget(context),
                      );
                    }
                  ),

              BlocBuilder<AdsCubit,AdsState>(
                builder: (context,state) {
                  if(state is AdsLoaded){
                    final list = [state.adsModel!.leftImage,state.adsModel!.rightImage];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeVertical! * 1.2,
                        0
                        ,SizeConfig.blockSizeVertical! * 1.2,0),
                    child: Card(
                      elevation: 90,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: AppLocale.of(context).currentCode == 'ar' ||
                            AppLocale.of(context).currentCode == 'ur'?
                        SizeConfig.screenHeight! * 0.12 : SizeConfig.screenHeight! * 0.12,
                        child: Swiper(
                          loop: false,
                          autoplay: true,
                          duration: 900,
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int imageIndex) {
                            return GestureDetector(
                              onTap: ()async{
                                if(imageIndex == 0) {
                                  await launch(state.adsModel!.urlLeft!);
                                }else{
                                  await launch(state.adsModel!.urlRight!);
                                }
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(imageUrl: list[imageIndex]!,
                                fit: BoxFit.fitWidth,)
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                  } else{
                    return Padding(
                      padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeVertical! * 1.2,
                          AppLocale.of(context).currentCode == 'ar' ||
                              AppLocale.of(context).currentCode == 'ur'?
                          SizeConfig.blockSizeVertical! * 1 :0
                          ,SizeConfig.blockSizeVertical! * 1.2,0),
                      child: adsShimmer(context),
                  );
                  }
                }
              ),
                ],
              ),
      ),
    );
  }

  _counterWidget(BuildContext context,int totalCount){
    return Stack(alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: SizeConfig.screenHeight! * 0.19 - SizeConfig.blockSizeHorizontal! * 6,
          backgroundColor: dark.withOpacity(0.1),
        ),

        Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical! * 4,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Utils.getScreenSize(SizeConfig.screenWidth!) != ScreenSize.small?
                Text('${Utils.getTranslatedText(context,'counter')}',
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 3.2,
                    fontWeight: FontWeight.bold, fontFamily: 'Impact',
                    letterSpacing: 2,
                    color: white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: const Offset(5.0, 5.0),
                        blurRadius: 15,
                      ),
                    ],),
                  textAlign: TextAlign.center,) :
                    Text('${Utils.getTranslatedText(context,'counter')}',
                       style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 3.2,
                      fontWeight: FontWeight.bold, fontFamily: 'Impact',
                         letterSpacing: 2,
                           foreground: Paint()..shader = linearGradient,
                         shadows: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.8),
                             offset: const Offset(5.0, 5.0),
                             blurRadius: 15,
                           ),
                         ],),
                      textAlign: TextAlign.center,),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: AnimatedFlipCounter(
                        value: totalCount,
                        duration: const Duration(seconds: 1),
                        prefix: "",
                        textStyle: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical! * 9,
                          foreground: Paint()..shader = linearGradient,
                          fontFamily: 'Impact',
                          shadows: [
                            BoxShadow(
                              color:  Colors.grey[800]!,
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text('KD',style: TextStyle(fontSize: SizeConfig.blockSizeVertical! * 4.5,
                      letterSpacing: 2,
                      foreground: Paint()..shader = linearGradient,
                      fontWeight: FontWeight.bold, fontFamily: 'Impact',
                      shadows: [
                        BoxShadow(
                          color:  Colors.grey[800]!,
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 1,
                        ),
                      ],),
                      textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

 Widget waitingWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          circleLoading(),
          SizedBox(height: SizeConfig.screenHeight! * 0.11,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              photoShimmer(context),
              photoShimmer(context),
            ],
          ),
        ],
      ),
    );
 }
}
