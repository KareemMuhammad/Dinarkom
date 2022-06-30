import 'package:dinarkom/blocs/language_bloc/locale_cubit.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';

class LanguageSheet extends StatefulWidget {
  final String? langCode;
  final LocaleCubit? langCubit;
  const LanguageSheet({Key? key, this.langCode, this.langCubit,}) : super(key: key);

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  int selectedIndex = 0;
  String langValue = 'en';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.9,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close),
                  color: white,
                ),

                Text('${Utils.getTranslatedText(context,'change_language')}',
                      style: const TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
              ],
            ),
          const SizedBox(height: 40,),
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
