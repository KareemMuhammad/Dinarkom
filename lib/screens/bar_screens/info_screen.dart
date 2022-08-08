import 'dart:convert';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login_bloc/login_cubit.dart';
import '../../service/user_service.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  const InfoScreen({Key? key, required this.title}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController =  TextEditingController();

  final TextEditingController passwordController =  TextEditingController();

  final TextEditingController nameController =  TextEditingController();

  final TextEditingController confirmPasswordController =  TextEditingController();

  final TextEditingController phoneController =  TextEditingController();

  final TextEditingController addPhoneController =  TextEditingController();

  @override
  void initState() {
    nameController.text = BlocProvider.of<LoginCubit>(context).getUser.name!;
    emailController.text = BlocProvider.of<LoginCubit>(context).getUser.email!;
    phoneController.text = BlocProvider.of<LoginCubit>(context).getUser.phone!;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: header('${Utils.getTranslatedText(context,'info')}'),
      ),
      body: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 25.0, top: 25.0),
                            child:  Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children:  <Widget>[
                                      Text(
                                      '${Utils.getTranslatedText(context,'name')}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 25.0, top: 2.0),
                            child:  Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                 Flexible(
                                  child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                              child: TextFormField(
                                                  controller: nameController,
                                                  style: const TextStyle(color: white),
                                                  validator: (val) {
                                                    return val!.isEmpty ? 'Name is empty!' : null;
                                                  },
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintStyle: TextStyle(color: white),
                                                    errorStyle: TextStyle(fontSize: 16),
                                                  )))),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: AppLocale.of(context).currentCode == 'ar' ||
                                    AppLocale.of(context).currentCode == 'ur'?
                                25.0 : 15.0, right: 25.0, top: 25.0),
                            child:  Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      '${Utils.getTranslatedText(context,'password')}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child:  Text(
                                      '${Utils.getTranslatedText(context,'confirm_password')}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: AppLocale.of(context).currentCode == 'ar' ||
                                    AppLocale.of(context).currentCode == 'ur'?
                                25.0 : 15.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      margin: AppLocale.of(context).currentCode == 'ar' ||
                                          AppLocale.of(context).currentCode == 'ur'?
                                      const EdgeInsets.only(left: 15):
                                     const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                          child: TextFormField(
                                            obscureText: true,
                                              style: const TextStyle(color: white),
                                              controller: passwordController,
                                              validator: (val) {
                                                return val!.isEmpty ? 'Password is empty!' : val.length < 8 ? 'Password is short!' : null;
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(color: white),
                                                hintText: "",
                                                errorStyle: TextStyle(fontSize: 16),
                                              )))),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                          child: TextFormField(
                                              obscureText: true,
                                              style: const TextStyle(color: white),
                                              controller: confirmPasswordController,
                                              validator: (val) {
                                                return val!.isEmpty || val != passwordController.text ? 'Passwords are not the same' : null;
                                              },
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(color: white),
                                                hintText: "",
                                                errorStyle: TextStyle(fontSize: 14),
                                              )))),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 25.0, top: 25.0),
                            child:  Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '${Utils.getTranslatedText(context,'email')}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                          child: TextFormField(
                                              style: const TextStyle(color: white),
                                              controller: emailController,
                                              validator: (val){
                                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)
                                                    ? null : 'Please enter a valid email!';
                                              },
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(color: white),
                                                errorStyle: TextStyle(fontSize: 16),
                                              )))),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: AppLocale.of(context).currentCode == 'ar' ||
                                    AppLocale.of(context).currentCode == 'ur'?
                                25.0 : 15.0, right: 25.0, top: 25.0),
                            child:  Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      '${Utils.getTranslatedText(context,'phone')}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                            left: 15.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                          child: TextFormField(
                                              style: const TextStyle(color: white),
                                              controller: phoneController,
                                              validator: (val) {
                                                return val!.isEmpty ? 'Phone number is empty!' : val.length != 8 ? 'Phone number is wrong!' : null;
                                              },
                                              maxLength: 8,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                counterStyle: TextStyle(color: white),
                                                hintStyle: TextStyle(color: white),
                                                errorStyle: TextStyle(fontSize: 16),
                                              )))),
                                  flex: 2,
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: ()async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    if(formKey.currentState!.validate()) {
                    var res =  await UserHttpService().updateUserDetails(nameController.text,
                          emailController.text,
                          BlocProvider.of<LoginCubit>(context).currentUser!.token!,
                          phoneController.text, passwordController.text,
                          confirmPasswordController.text,
                        BlocProvider.of<LoginCubit>(context).currentUser!.nationalID!
                    );
                    debugPrint(jsonDecode(res.body).toString());
                     if(jsonDecode(res.body)['status'] != false){
                       BlocProvider.of<LoginCubit>(context)
                           .getCurrentUser(BlocProvider.of<LoginCubit>(context)
                           .currentUser!.token!);
                       setState(() {
                         emailController.clear();
                         nameController.clear();
                         phoneController.clear();
                         passwordController.clear();
                         confirmPasswordController.clear();
                         Utils.showSnack(
                             'Your data has been updated', 'Done', context,
                             black);
                       });
                     }else{
                       Utils.showSnack(
                           jsonDecode(res.body)['message'], 'Failed', context,
                           black);
                     }
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
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical! * 5,vertical: 8),
                      child: Text('${Utils.getTranslatedText(context,'update')}',
                        style:  TextStyle(fontSize: SizeConfig.blockSizeVertical! * 2.5,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,

                        ),),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25,),
            ],
          ),
      ),
    );
  }

  Widget header(String text){
    return Text(text,style:
    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.8,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

}
