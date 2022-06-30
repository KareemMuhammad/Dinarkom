import 'package:dinarkom/blocs/language_bloc/locale_cubit.dart';
import 'package:dinarkom/screens/auth/login_screen.dart';
import 'package:dinarkom/screens/main_screen.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FirstSheetOfLanguage extends StatefulWidget {
  final LocaleCubit? langCubit;
  const FirstSheetOfLanguage({Key? key, this.langCubit}) : super(key: key);

  @override
  _FirstSheetOfLanguageState createState() => _FirstSheetOfLanguageState();
}

class _FirstSheetOfLanguageState extends State<FirstSheetOfLanguage> {
  int selectedIndex = 0;
  String langValue = 'en';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.6,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Translations.languages.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      value: index + 1,
                      groupValue: selectedIndex,
                      title: Text(Translations.languages[index],style: const
                      TextStyle(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.bold
                      ),),
                      activeColor: light,
                      onChanged: (value){
                        setState(() {
                          selectedIndex = index + 1;
                          switch(value){
                            case 1:
                              langValue = 'en';
                              break;
                            case 2:
                              langValue = 'ar';
                              break;
                            case 3:
                              langValue = 'ur';
                              break;
                            case 4:
                              langValue = 'fil';
                              break;
                            default: langValue = 'en';
                          }
                        });
                      });
                },
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                switch(langValue){
                  case 'en':
                    widget.langCubit!.setLanguage('en');
                    break;
                  case 'ar':
                    widget.langCubit!.setLanguage('ar');
                    break;
                  case 'ur':
                    widget.langCubit!.setLanguage('ur');
                    break;
                  case 'fil':
                    widget.langCubit!.setLanguage('fil');
                    break;
                  default:  widget.langCubit!.setLanguage('en');
                }
                Navigator.pushReplacement(context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 400),
                      child: const LoginScreen()),);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${Utils.getTranslatedText(context,'save')}',
                  style:  TextStyle(fontSize: 20,color: Colors.grey[700],fontWeight: FontWeight.bold),),
              ),

            ),
            const SizedBox(height: 50,),
          ],
      ),
    );
  }
}
