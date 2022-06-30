import 'package:dinarkom/blocs/login_bloc/login_cubit.dart';
import 'package:dinarkom/screens/bar_screens/my_relations.dart';
import 'package:dinarkom/screens/bar_screens/add_releveant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/constants.dart';
import '../../utils/shared.dart';
import 'info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum CurrentInfo{password,name,relevant,none}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: header('${Utils.getTranslatedText(context,'profile')}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 10,),
            _customWidget('${Utils.getTranslatedText(context,'info')}',
                Icons.person_outline,CurrentInfo.name),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
            _customWidget(Utils.getTranslatedText(context,'relevant')!.split(' ')[1],
                Icons.people,CurrentInfo.password),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
            _customWidget('${Utils.getTranslatedText(context,'relevant')}',
                Icons.group_add,CurrentInfo.relevant),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: white,),
            ),
          ],
        ),
      ),
    );
  }

  void changeInfo(CurrentInfo info,String title){
    switch(info){
      case CurrentInfo.relevant:
        Navigator.push(context,
          PageTransition(
              type: PageTransitionType
                  .rightToLeft,
              duration: const Duration(
                  milliseconds: 300),
              child: AddRelevantScreen(title: title)),);
        break;
      case CurrentInfo.name:
        Navigator.push(context,
          PageTransition(
              type: PageTransitionType
                  .rightToLeft,
              duration: const Duration(
                  milliseconds: 300),
              child: InfoScreen(title: title)),);
        break;
      case CurrentInfo.password:
        Navigator.push(context,
          PageTransition(
              type: PageTransitionType
                  .rightToLeft,
              duration: const Duration(
                  milliseconds: 300),
              child: MyRelationsScreen(token: BlocProvider.of<LoginCubit>(context).getUser.token!)),);
        break;
      default : CurrentInfo.none;

    }
  }

  Widget _customWidget(String title,IconData icon,CurrentInfo info){
    return GestureDetector(
      onTap: (){
        changeInfo(info,title);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          color: greyOpacity,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(icon,color: white,size: 20,),
            const SizedBox(width: 10,),
            Expanded(child: Text(title,style: TextStyle(color: white,
                fontSize: SizeConfig.blockSizeVertical! * 2,
                fontWeight: FontWeight.bold),
              maxLines: 1,overflow: TextOverflow.ellipsis,)),
            const Icon(Icons.arrow_forward_ios,color: white,size: 20,),
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
}
