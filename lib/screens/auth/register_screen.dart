import 'package:dinarkom/utils/shared.dart';
import 'package:dinarkom/widgets/auth/register_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,15.0,10,10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){
                          Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back,),
                        color: white,),
                        CircleAvatar(
                            backgroundColor: white,
                            radius: 23,
                            child: Hero(
                                tag: 'logoTag',
                            child: Image.asset('assets/empty_logo.png',fit: BoxFit.cover,))),
                        const SizedBox(width: 10,),
                        const Text('Dinarkoom',style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration:  BoxDecoration(
                        color: greyOpacity,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                      ),
                      child: const SingleChildScrollView(
                        child: Padding(
                          padding:  EdgeInsets.all(20.0),
                          child: RegisterWidget()
                        ),
                      ),
                    ),
                  ),

                ],
              ),
      ),
    );
  }
}
