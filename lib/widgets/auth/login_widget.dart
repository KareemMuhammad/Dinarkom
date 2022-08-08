import 'package:delayed_display/delayed_display.dart';
import 'package:dinarkom/screens/auth/forgot_password.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../blocs/login_bloc/login_state.dart';
import '../../screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/main_screen.dart';
import '../helpers/shared_widgets.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isUnCover = false;

  final TextEditingController emailController =  TextEditingController();

  final TextEditingController passwordController =  TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
      return BlocConsumer<LoginCubit,LoginState>(
        listener: (ctx,state){
          if(state is LoginFailed){
            Utils.showSnack('', state.message, context, black);
          }else if (state is LoginSuccessful){
            loginCubit.getCurrentUser(state.appUser.token!);
            Navigator.pushReplacement(context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 400),
                  child: const MainScreen()),);
          }
        },
        builder: (ctx,state){
          if(state is LoadingLogin){
            return loading();
          }else {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  DelayedDisplay(
                    fadeIn: true,
                    delay: const Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: greyOpacity))
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "${Utils.getTranslatedText(context,'email')}",
                                hintStyle: TextStyle(color: Colors.grey[700]),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.email_outlined,color: Colors.grey[700],),
                              ),
                              validator: (val){
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)
                                    ? null : 'Please enter a valid email!';
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: greyOpacity))
                            ),
                            child:  TextFormField(
                              controller: passwordController,
                              obscureText: isUnCover ? false : true,
                              decoration: InputDecoration(
                                hintText: "${Utils.getTranslatedText(context,'password')}",
                                hintStyle: TextStyle(color: Colors.grey[700]),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(isUnCover ? Icons.remove_red_eye :
                                  Icons.remove_red_eye_outlined,size: 19,color: Colors.grey[700],),
                                  onPressed: (){
                                    setState(() {
                                      isUnCover = !isUnCover;
                                    });
                                  },
                                ),
                              ),
                              validator: (val) {
                                return val!.isEmpty ? 'Password is empty!' : null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  DelayedDisplay(
                      fadeIn: true,
                      delay: const Duration(seconds: 1),
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 400),
                                  child: const ForgotPassword()),);
                          },
                          child: Text("${Utils.getTranslatedText(context,'forget_password_text')}",
                            style: const TextStyle(color: white,fontSize: 16),))),
                  const SizedBox(height: 20,),
                  DelayedDisplay(
                    fadeIn: true,
                    delay: const Duration(seconds: 1),
                    child: GestureDetector(
                      onTap: (){
                        if(formKey.currentState!.validate()) {
                          loginCubit.login(
                              emailController.text, passwordController.text);
                        }
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[600]
                        ),
                        child: Center(
                          child: Text("${Utils.getTranslatedText(context,'login')}",
                            style: const TextStyle(color: white, fontWeight: FontWeight.bold,fontSize: 18,),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  DelayedDisplay(
                    fadeIn: true,
                    delay: const Duration(seconds: 1),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400),
                              child: const MainScreen()),);
                        //    }
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1,color: Colors.grey[600]!)
                        ),
                        child: Center(
                          child: Text("${Utils.getTranslatedText(context,'login_guest')}",
                            style: const TextStyle(color: white, fontWeight: FontWeight.bold,fontSize: 18,),),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  DelayedDisplay(
                    fadeIn: true,
                    delay: const Duration(seconds: 1),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400),
                              child: const RegisterScreen()),);
                      },
                      child: RichText(textAlign: TextAlign.center,
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '${Utils.getTranslatedText(context,'account_ask')} ',
                                  style: const TextStyle(color: white,fontSize: 16)
                              ),
                              TextSpan(
                                  text: '${Utils.getTranslatedText(context,'register_text')}',
                                  style: const TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.bold
                                      ,decoration: TextDecoration.underline)
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
