import 'package:dinarkom/blocs/winners_bloc/winners_cubit.dart';
import 'package:dinarkom/blocs/winners_bloc/winners_state.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/language_delegate.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/helpers/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../nav_screens/terms_screen.dart';

class WinnersScreen extends StatefulWidget {
  const WinnersScreen({Key? key}) : super(key: key);

  @override
  State<WinnersScreen> createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {

  @override
  void initState() {
    BlocProvider.of<WinnersCubit>(context).getWinners();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final String _currentMonth = DateFormat('MMMM', AppLocale.of(context).currentCode).format(DateTime.now()).toString();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [

                  Text('${Utils.getTranslatedText(context,'winners')} $_currentMonth',
                            style: const TextStyle(color: white,fontSize: 25,fontFamily: 'Qadishia',),),

              SizedBox(height: SizeConfig.screenHeight! * 0.05,),
                  BlocBuilder<WinnersCubit,WinnersState>(
                    builder: (context,state) {
                      return state is WinnersLoaded ?
                      Column(
                        children: [
                          Container(
                            color: greyOpacity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Table(
                              border: TableBorder.all(color: Colors.grey,width: 2,),
                              children: [
                              TableRow(
                              children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${Utils.getTranslatedText(context,'name')}',
                                style: const  TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: white),),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${Utils.getTranslatedText(context,'digital_photo_winners')}',
                                style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: white),),
                              ),
                            ])
                              ]
                            ),
                          ),
                         state.winnersList!.isEmpty?
                         Center(child: Column(
                           children: [
                             SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                             Image.asset('assets/empty.png',
                               height: SizeConfig.blockSizeVertical! * 25,
                               width: SizeConfig.blockSizeVertical! * 25,),
                             SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
                             footer('${Utils.getTranslatedText(context,'winners_hint')}'),
                           ],
                         ))
                         :Container(
                            color: greyOpacity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Table(
                              border: TableBorder.all(color: Colors.grey,width: 2,),
                              children:
                              (state.winnersList)!.map((e) {
                                  return TableRow(
                                      children: [
                                        Container(
                                          color: greyOpacity,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e.winnerName!,
                                            style: const  TextStyle(fontSize: 17,
                                                fontWeight: FontWeight.bold,color: white),),
                                        ),
                                        Container(
                                          color: greyOpacity,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e.prize!,
                                            style: const TextStyle(fontSize: 17,
                                                fontWeight: FontWeight.bold,color: white),),
                                        ),
                                      ]);
                                }).toList(),
                            ),
                          ),
                        ],
                      ) : circleLoading();
                    }
                  ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: SizeConfig.blockSizeVertical! * 5,),
                child: Text('${Utils.getTranslatedText(context,'winners_note')}'
                  ,style: const TextStyle(color: white,fontSize: 15,),textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
