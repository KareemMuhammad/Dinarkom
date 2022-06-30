import 'package:dinarkom/blocs/register_bloc/register_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/register_bloc/register_state.dart';
import '../helpers/shared_widgets.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key,}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController emailController =  TextEditingController();

  final TextEditingController passwordController =  TextEditingController();

  final TextEditingController nameController =  TextEditingController();

  final TextEditingController confirmPasswordController =  TextEditingController();

  final TextEditingController phoneController =  TextEditingController();

  final TextEditingController addPhoneController =  TextEditingController();

  final TextEditingController nationalIdController =  TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RegisterCubit registerCubit = BlocProvider.of<RegisterCubit>(context);
   return BlocConsumer<RegisterCubit,RegisterState>(
        listener: (ctx,state){
          if(state is RegisterFailed){
            Utils.showSnack('', state.message, context, black);
          }else if (state is RegisterSuccessful) {
            Utils.showSnack('', state.message, ctx, black);
            emailController.clear();
            nameController.clear();
            nationalIdController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
            phoneController.clear();
            addPhoneController.clear();
          }
        },
        builder: (context,state) {
          if(state is LoadingRegistration) {
            return loading();
          }else {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,12),
                    child: Text('${Utils.getTranslatedText(context,'register_title')}',textAlign: TextAlign.center ,
                      style: const TextStyle(color: white, fontSize: 15, fontWeight: FontWeight.w500,),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: white),
                      decoration: textInputDecorationSign('${Utils.getTranslatedText(context,'register_name')}', Icons.person_outline),
                      validator: (val) {
                        return val!.isEmpty ? 'Name is empty!' : null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nationalIdController,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: white),
                      decoration: textInputDecorationSign('${Utils.getTranslatedText(context,
                          'register_national_id')}', FontAwesomeIcons.key,),
                      validator: (val) {
                        return val!.isEmpty ? 'National ID is empty!' : val.length != 12 ? 'National ID is wrong!' : null;
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth! * 0.44,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          style: const TextStyle(color: white),
                          decoration: textInputDecorationSign2("${Utils.getTranslatedText(context,'register_password')}",),
                          validator: (val) {
                            return val!.isEmpty ? 'Password is empty!' : val.length < 8 ? 'Password is short!' : null;
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth! * 0.44,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          style: const TextStyle(color: white),
                          decoration: textInputDecorationSign2("${Utils.getTranslatedText(context,'register_confirm_password')}"),
                          validator: (val) {
                            return val!.isEmpty || val != passwordController.text ? 'Passwords are not the same' : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: white),
                      decoration: textInputDecorationSign('${Utils.getTranslatedText(context,'register_email')}', Icons.email_outlined,),
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)
                            ? null : 'Please enter a valid email!';
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth! * 0.44,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          style: const TextStyle(color: white),
                          decoration: textInputDecorationSign2('${Utils.getTranslatedText(context,'register_phone')}'),
                          validator: (val) {
                            return val!.isEmpty ? 'Phone number is empty!' : val.length != 8 ? 'Phone number is wrong!' : null;
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth! * 0.44,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          controller: addPhoneController,
                          style: const TextStyle(color: white),
                          decoration: textInputDecorationSign2("${Utils.getTranslatedText(context,'another_phone')}"),
                          validator: (val) {
                            return val!.isEmpty ? null : val.length != 8 ? 'Phone number is wrong!' : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  GestureDetector(
                    onTap: ()async{
                      if(formKey.currentState!.validate()) {
                        registerCubit.signUp(
                            nameController.text, emailController.text,
                            phoneController.text,addPhoneController.text.isEmpty ? '' :
                        addPhoneController.text, passwordController.text,
                            nationalIdController.text,
                            confirmPasswordController.text
                        );
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
                        child: Text("${Utils.getTranslatedText(context,'register_button')}",
                          style: const TextStyle(color: white, fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: RichText(textAlign: TextAlign.center,
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: '${Utils.getTranslatedText(context,'have_account')}',
                                style: const TextStyle(color: white,fontSize: 16)
                            ),
                            TextSpan(
                                text: '${Utils.getTranslatedText(context,'sign_in_button')}',
                                style: const TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.bold
                                    ,decoration: TextDecoration.underline)
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    nationalIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addPhoneController.dispose();
    super.dispose();
  }
}


