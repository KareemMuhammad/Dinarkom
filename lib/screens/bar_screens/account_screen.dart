import 'dart:convert';
import 'package:dinarkom/screens/auth/login_screen.dart';
import 'package:dinarkom/screens/bar_screens/profile_screen.dart';
import 'package:dinarkom/service/user_service.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/dialogs/delete_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../nav_screens/purchases_screen.dart';

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
            _customWidget('${Utils.getTranslatedText(context,'orders')}',
                Icons.shopping_bag_outlined,navigateToPurchasesScreen),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),

            _customWidget(loginCubit.getToken.isNotEmpty ?
            '${Utils.getTranslatedText(context,'logout')}':
            '${Utils.getTranslatedText(context,'login')}',
                loginCubit.getToken.isNotEmpty ? Icons.logout :
                Icons.login,navigateToLoginScreen),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
            loginCubit.getToken.isNotEmpty ?
            GestureDetector(
              onTap: ()async{
                if(loginCubit.currentUser!.id != null){
                  if(loginCubit.getToken.isNotEmpty){
                dynamic result = await showDialog(
                    context: context,
                    builder: (_) =>
                        Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            backgroundColor: greyOpacity,
                            child: const DeleteAccountDialog()));
                if (result == 'delete') {
                  var res = await UserHttpService().deleteAccount(loginCubit.currentToken!);
                  debugPrint(jsonDecode(res.body).toString());
                  loginCubit.getCurrentUser('');
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('authToken', '');
                  Navigator.pushReplacement(context,
                    PageTransition(
                        type: PageTransitionType
                            .rightToLeft,
                        duration: const Duration(
                            milliseconds: 300),
                        child: const LoginScreen()),);
                     }
                  }
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text( '${Utils.getTranslatedText(context, 'delete_account')}',style:
                TextStyle(color: Colors.grey,
                    fontSize: SizeConfig.blockSizeVertical! * 2,
                    fontWeight: FontWeight.bold),),
              ),
            ) : const SizedBox()
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
    if(loginCubit.currentUser!.id != null) {
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

  void navigateToPurchasesScreen(){
    if(loginCubit.currentUser!.id != null) {
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
  }

  void navigateToLoginScreen()async {
    if (loginCubit.currentUser!.id != null) {
        var result = await loginCubit.logout(loginCubit.getToken);
        debugPrint(result.toString());
        if (result) {
          loginCubit.getCurrentUser('');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
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
}
