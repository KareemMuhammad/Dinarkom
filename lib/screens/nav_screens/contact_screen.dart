import 'package:dinarkom/service/about_service.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/language_delegate.dart';
import '../../utils/shared.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController emailController =  TextEditingController();

  final TextEditingController subjectController =  TextEditingController();

  final TextEditingController messageController =  TextEditingController();

  final TextEditingController nameController =  TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 8),
                    children: [

                      Align(
                        alignment: Alignment.topCenter,
                        child: Text('${Utils.getTranslatedText(context,'contact')}',
                          style: const TextStyle(color: white,fontSize: 25,fontFamily: 'Qadishia',),),
                      ),
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
                                          style: const TextStyle(color: white),
                                          controller: nameController,
                                            validator: (val) {
                                              return val!.isEmpty ? 'Name is empty!' : null;
                                            },
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextStyle(fontSize: 16),
                                                hintStyle: TextStyle(color: white),
                                                hintText: ' '
                                            )))),
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
                                              errorStyle: TextStyle(fontSize: 16),
                                              hintStyle: TextStyle(color: white),
                                              hintText: " ",
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
                                    '${Utils.getTranslatedText(context,'subject')}',
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
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                            style: const TextStyle(color: white),
                                          controller: subjectController,
                                            validator: (val) {
                                              return val!.isEmpty ? 'Subject is empty!' : null;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(fontSize: 16),
                                              hintStyle: TextStyle(color: white),
                                              hintText: " ",
                                            )))),
                                flex: 2,
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
                                    '${Utils.getTranslatedText(context,'message')}',
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
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                            style: const TextStyle(color: white),
                                            controller: messageController,
                                            validator: (val) {
                                              return val!.isEmpty ? 'Message is empty!' : null;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(fontSize: 16),
                                              hintStyle: TextStyle(color: white),
                                              hintText: " ",
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
                   await AboutService().sendContactService(nameController.text,
                        emailController.text,
                        subjectController.text, messageController.text);
                    setState(() {
                      emailController.clear();
                      nameController.clear();
                      subjectController.clear();
                      messageController.clear();
                    });
                   Utils.showSnack(
                       'Your message has been recorded', 'Done', context,
                       black);
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
                    child: Text(Utils.getTranslatedText(context,'send_link')!.split(' ')[0],
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
}
