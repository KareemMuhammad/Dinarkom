import 'package:dinarkom/utils/constants.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  bool? _check = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: black,
      height: SizeConfig.screenHeight! * 0.4,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.close),
              color: white,
            ),
          ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${Utils.getTranslatedText(context,'delete_hint')}',style:
                    TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.2,
                        fontWeight: FontWeight.bold,height: 1),textAlign: TextAlign.start,),
                  ),
                ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 3,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: ()async{
                    if(_check!) {
                      Navigator.pop(context,'delete');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: white,
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white70,
                            Colors.white,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            offset: const Offset(5.0, 5.0),
                            blurRadius: 15,
                          ),
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical! * 5,vertical: 8),
                      child: Text('${Utils.getTranslatedText(context,'agree')}',
                        style:  TextStyle(fontSize: SizeConfig.blockSizeVertical! * 2,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ),
                ),
              ),
              Checkbox(value: _check ?? false, onChanged: (bool? value){
                setState(() {
                  _check = value;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }
}