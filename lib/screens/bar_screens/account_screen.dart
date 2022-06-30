import 'dart:ui';
import 'package:dinarkom/blocs/login_bloc/login_state.dart';
import 'package:dinarkom/screens/auth/login_screen.dart';
import 'package:dinarkom/screens/bar_screens/profile_screen.dart';
import 'package:dinarkom/screens/nav_screens/terms_screen.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/login_bloc/login_cubit.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late LoginCubit loginCubit;
  @override
  void initState() {
    loginCubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: SizeConfig.blockSizeVertical! * 10,),
             _customWidget('${Utils.getTranslatedText(context,'profile')}',
                 Icons.person_outline,navigateToMyInfoScreen),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
            _customWidget('${Utils.getTranslatedText(context,'terms_title')}',
                Icons.copyright,navigateToTermsScreen),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),

            _customWidget('${Utils.getTranslatedText(context,'logout')}',
                Icons.logout,navigateToLoginScreen),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customWidget(String title,IconData icon,VoidCallback function){
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          color: greyOpacity,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(icon,color: white,size: 20,),
            const SizedBox(width: 10,),
            Expanded(child: Text(title,style: TextStyle(color: white,
                fontSize: SizeConfig.blockSizeVertical! * 2,
                fontWeight: FontWeight.bold),
              maxLines: 1,overflow: TextOverflow.ellipsis,)),
             const Icon(Icons.arrow_forward_ios,color: white,size: 20,),
          ],
        ),
      ),
    );
  }

  void navigateToMyInfoScreen(){
    if(BlocProvider.of<LoginCubit>(context).currentUser != null) {
      Navigator.push(context,
        PageTransition(
            type: PageTransitionType
                .rightToLeft,
            duration: const Duration(
                milliseconds: 300),
            child: const ProfileScreen()),);
    }else{
      Navigator.pushReplacement(context,
        PageTransition(
            type: PageTransitionType
                .rightToLeft,
            duration: const Duration(
                milliseconds: 300),
            child: const LoginScreen()),);
    }
  }

  void navigateToTermsScreen(){
    Navigator.push(context,
      PageTransition(
          type: PageTransitionType
              .rightToLeft,
          duration: const Duration(
              milliseconds: 300),
          child: const TermsConditionScreen()),);
  }

  void navigateToLoginScreen()async {
    if (BlocProvider.of<LoginCubit>(context).currentUser != null) {
        var result = await loginCubit.logout(BlocProvider
            .of<LoginCubit>(context).currentUser!.token!);
        if (result) {
          loginCubit.getCurrentUser('');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
    }
  }
}
