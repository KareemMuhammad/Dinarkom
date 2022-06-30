import 'dart:ui';
import 'package:dinarkom/blocs/bar_bloc/bar_cubit.dart';
import 'package:dinarkom/blocs/bar_bloc/bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/shared.dart';

class CustomBottomBar extends StatefulWidget {
  final PageController? page;
  const CustomBottomBar({Key? key, this.page}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final BarCubit barCubit = BlocProvider.of<BarCubit>(context);
    return BlocBuilder<BarCubit,BarState>(
      builder: (BuildContext context, state) {
         return Container(
           color: Colors.grey.withOpacity(0.5),
           child: ClipRect(
             child: BackdropFilter(
               filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
               child: Container(
                 padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                 width: SizeConfig.screenWidth,
                 height: SizeConfig.blockSizeVertical! * 7,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     GestureDetector(
                       onTap: (){
                         widget.page!.jumpToPage(0);
                         barCubit.index = 0;
                       },
                       child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey[800]!,
                                 offset: const Offset(-6.0, 6.0),
                                 spreadRadius: 1,
                                   blurRadius: 1
                               ),
                             ],
                           ),
                           child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 FontAwesomeIcons.envelopeOpenText,
                                 color: state.index == 0 ? light : Colors.grey[700],
                                 size: SizeConfig.blockSizeVertical! * 2.5,
                               ),
                             ),),
                     ),
                     GestureDetector(
                       onTap: (){
                         widget.page!.jumpToPage(1);
                         barCubit.index = 1;
                       },
                       child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey[800]!,
                                 offset: const Offset(-6.0, 6.0),
                                 spreadRadius: 1,
                                   blurRadius: 1
                               ),
                             ],
                           ),
                           child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 FontAwesomeIcons.userLarge,
                                 color: state.index == 1 ? light : Colors.grey[700],
                                 size: SizeConfig.blockSizeVertical! * 2.4,
                               ),
                             ),),
                     ),
                     GestureDetector(
                       onTap: (){
                         widget.page!.jumpToPage(2);
                         barCubit.index = 2;
                       },
                       child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey[800]!,
                                 offset: const Offset(-6.0, 6.0),
                                 spreadRadius: 1,
                                 blurRadius: 1
                               ),
                             ],
                           ),
                           child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(
                                 FontAwesomeIcons.houseChimney,
                                 color: state.index == 2 ? light : Colors.grey[700],
                                 size: SizeConfig.blockSizeVertical! * 2.5,
                               ),
                             ),),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         );
      },
    );
  }
}
