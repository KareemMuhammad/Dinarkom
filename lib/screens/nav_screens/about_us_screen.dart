import 'package:dinarkom/blocs/about_bloc/about_cubit.dart';
import 'package:dinarkom/blocs/about_bloc/about_state.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/helpers/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsScreen extends StatefulWidget {
  final String? code;
  const AboutUsScreen({Key? key, this.code}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  AboutCubit? aboutCubit;

  @override
  void initState() {
    aboutCubit = BlocProvider.of<AboutCubit>(context);
    super.initState();
    getLang();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: header('${Utils.getTranslatedText(context,'about')}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      BlocBuilder<AboutCubit,AboutState>(
                        builder: (ctx,state) {
                            if(state is AboutLoaded) {
                              return Container(
                                      margin: const EdgeInsets.fromLTRB(12,0,12,12),
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: greyOpacity,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 10,),
                                              header('${Utils.getTranslatedText(context,'about_header')}'),
                                              const SizedBox(height: 10,),
                                              RichText(textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: '"${state.aboutModel!.first.aboutPf}"',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig.blockSizeVertical! *
                                                                2.5, color: white,
                                                            height: 1.5,
                                                            fontWeight: FontWeight.bold,)
                                                      ),
                                                      TextSpan(
                                                          text: '"${state.aboutModel!.first.aboutPs}"',
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            fontSize: SizeConfig.blockSizeVertical! *
                                                                2.5, color: white,
                                                            fontWeight: FontWeight.bold,)
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 10,),
                                              header('${Utils.getTranslatedText(context,'principle_header')}'),
                                              const SizedBox(height: 10,),
                                              footer('${state.aboutModel!.first.principles}'),
                                              const SizedBox(height: 10,),
                                              header('${Utils.getTranslatedText(context,'mission_header')}'),
                                              const SizedBox(height: 10,),
                                              footer('${state.aboutModel!.first.mission}'),
                                              const SizedBox(height: 10,),
                                              header('${Utils.getTranslatedText(context,'vision_header')}'),
                                              const SizedBox(height: 10,),
                                              footer('${state.aboutModel!.first.vision}'),
                                            ],
                                          ),
                              );
                            } else if (state is AboutLoadFailure) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('Error, please try again!',style:
                                    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 3),),
                                  );
                                  }else {
                              return loading();
                            }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),

    );
  }

  Widget header(String text){
    return Text('$text',style:
    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 3,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

  Widget footer(String text){
    return Text('"$text"',style:
    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.5,
        fontWeight: FontWeight.bold,height: 1.3),textAlign: TextAlign.center,);
  }

  void getLang()async{
   aboutCubit!.getCurrentAboutLang(widget.code!);
  }

}
