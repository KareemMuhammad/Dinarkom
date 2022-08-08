import 'package:dinarkom/model/relevant_model.dart';
import 'package:dinarkom/repositories/user_repo.dart';
import 'package:dinarkom/screens/bar_screens/update_relevant_screen.dart';
import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

class MyRelationsScreen extends StatefulWidget {
  final String token;

  const MyRelationsScreen({Key? key, required this.token}) : super(key: key);

  @override
  _MyRelationsScreenState createState() => _MyRelationsScreenState();
}

class _MyRelationsScreenState extends State<MyRelationsScreen> {
 late Future<RelevantModel> getRelatives;

 @override
  void initState() {
   getRelatives = UserRepository().getMyRelevant(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text(Utils.getTranslatedText(context,'relevant')!.split(' ')[1],
          style:
          TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.8,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            getRelatives =  UserRepository().getMyRelevant(widget.token);
          });
        },
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<RelevantModel>(
              future:  getRelatives,
              builder: (BuildContext context, AsyncSnapshot<RelevantModel> snapshot) {
                return snapshot.data != null && snapshot.data!.relatives!.isNotEmpty?
                ListView.builder(
                    itemCount: snapshot.data!.relatives!.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (ctx,index){
                      var relative = snapshot.data!.relatives![index];
                      return Card(
                        elevation: 3,
                        color: greyOpacity,
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context,
                              PageTransition(
                                  type: PageTransitionType
                                      .rightToLeft,
                                  duration: const Duration(
                                      milliseconds: 300),
                                  child: UpdateRelevantScreen(relevantModel: relative, title: '',)),);
                          },
                          title: Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              header(relative.relativeName!),
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(8),
                          subtitle: footer(relative.relativeRelation!),
                          trailing:  Icon(Icons.update,color: light,),
                        ),
                      );
                    }) : Center(child: Column(
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                        Image.asset('assets/empty.png',
                            height: SizeConfig.blockSizeVertical! * 25,
                        width: SizeConfig.blockSizeVertical! * 25,),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
                        footer('${Utils.getTranslatedText(context,'relevant_hint')}'),
                      ],
                    ));
              },
            ),
          ),
      ),
    );
  }

 Widget footer(String text){
   return Text('$text',style:
   TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2,
       fontWeight: FontWeight.bold,height: 1.5),textAlign: TextAlign.start,);
 }

 Widget header(String text){
   return Text(text,style:
   TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.5,
       fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
 }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

}
