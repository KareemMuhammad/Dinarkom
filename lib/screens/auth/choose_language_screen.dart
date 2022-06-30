import 'dart:ui';
import 'package:dinarkom/blocs/language_bloc/locale_cubit.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/dialogs/first_language_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final LocaleCubit langCubit = BlocProvider.of<LocaleCubit>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
       body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
             children: [
             CircleAvatar(
                     backgroundColor: white,
                     radius: 40,
                     child: Image.asset('assets/empty_logo.png',fit: BoxFit.cover,)),
               const SizedBox(height: 10,),
               const Text('Dinarkom',style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 28),),
               const SizedBox(height: 15,),
               Padding(
                       padding: const EdgeInsets.symmetric(vertical: 15),
                       child: Container(
                         height: SizeConfig.blockSizeVertical! * 6,
                         decoration: BoxDecoration(
                             color: greyOpacity,
                           borderRadius: BorderRadius.circular(15)
                         ),
                         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Flexible(
                               child: Text('${Utils.getTranslatedText(context,'change_language')}',
                                 style: TextStyle(color: white,
                                     fontSize: SizeConfig.blockSizeVertical! * 2.5,
                                     fontWeight: FontWeight.bold),
                               textAlign: TextAlign.center,),
                             ),
                             const SizedBox(width: 10,),
                              Icon(Icons.language,color: white,size: SizeConfig.blockSizeVertical! * 3.5,),
                           ],
                         ),
                       ),
                     ),
               FirstSheetOfLanguage(langCubit: langCubit,),
             ],
           ),
    );
  }
}
