import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: header('${Utils.getTranslatedText(context,'terms_title')}'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(12,0,12,12),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: greyOpacity,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: footer('${Utils.getTranslatedText(context,'terms')}')),
                    ],
                  ),
                ),
              ],
            ),
        ),

    );
  }
}

Widget footer(String text){
  return Text('"$text"',style:
  TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.3,
      fontWeight: FontWeight.bold,height: 1.5),textAlign: TextAlign.start,);
}

Widget header(String text){
  return Text(text,style:
  TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.7,
      fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
}

