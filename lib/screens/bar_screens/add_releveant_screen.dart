import 'dart:convert';
import 'dart:ui';
import 'package:dinarkom/service/user_service.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login_bloc/login_cubit.dart';

class AddRelevantScreen extends StatefulWidget {
  final String title;
  const AddRelevantScreen({Key? key, required this.title}) : super(key: key);

  @override
  _AddRelevantScreenState createState() => _AddRelevantScreenState();
}

class _AddRelevantScreenState extends State<AddRelevantScreen> {
  final TextEditingController natIdController =  TextEditingController();

  final TextEditingController relationController =  TextEditingController();

  final TextEditingController nameController =  TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: header('${Utils.getTranslatedText(context,'relevant')}'),
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
                                            style: const TextStyle(color: white),
                                          controller: nameController,
                                            validator: (val) {
                                              return val!.isEmpty ? 'Name is empty!' : null;
                                            },
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(color: white),
                                                hintText: '...',
                                                errorStyle: TextStyle(fontSize: 16),
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
                                    '${Utils.getTranslatedText(context,'national_id')}',
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
                                            controller: natIdController,
                                            maxLength: 12,
                                            keyboardType: TextInputType.number,
                                            validator: (val) {
                                              return val!.isEmpty ? 'National ID is empty!'
                                                  : val.length != 12 ? 'National ID is wrong!' : null;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(color: white),
                                              hintText: "",
                                              counterStyle: TextStyle(color: white,fontSize: 14),
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
                                    '${Utils.getTranslatedText(context,'relation')}',
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
                                            controller: relationController,
                                            validator: (val) {
                                              return val!.isEmpty ? 'Relevant is empty!' : null;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(fontSize: 16),
                                              hintStyle: TextStyle(color: white),
                                              hintText: "",
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
                 var res =  await UserHttpService().addRelevant(nameController.text,
                        BlocProvider.of<LoginCubit>(context).currentUser!.token!,
                        natIdController.text, relationController.text);
                // debugPrint(jsonDecode(res.body).toString());
                 if(jsonDecode(res.body)['status'] != false) {
                   setState(() {
                     natIdController.clear();
                     nameController.clear();
                     relationController.clear();
                   });
                   Utils.showSnack(
                       'Your relevant has been added', 'Done', context,
                       black);
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
                    child: Text('${Utils.getTranslatedText(context,'save')}',
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
    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 3,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    nameController.dispose();
    relationController.dispose();
    natIdController.dispose();
    super.dispose();
  }

}
