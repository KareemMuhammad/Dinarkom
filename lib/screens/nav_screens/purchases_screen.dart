import 'package:dinarkom/model/purchase_model.dart';
import 'package:dinarkom/repositories/payment_repo.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/shared.dart';

class PurchasesScreen extends StatefulWidget {
  final String token;
  const PurchasesScreen({Key? key, required this.token}) : super(key: key);

  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {

  late Future<PurchaseModel> getPurchases;

  @override
  void initState() {
    debugPrint(widget.token);
    getPurchases = PaymentRepo().getMyPurchases(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text(Utils.getTranslatedText(context,'orders')!,
          style:
          TextStyle(color: white, fontSize: SizeConfig.blockSizeVertical! * 2.8,
              fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            getPurchases = PaymentRepo().getMyPurchases(widget.token);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<PurchaseModel>(
            future:  getPurchases,
            builder: (BuildContext context, AsyncSnapshot<PurchaseModel> snapshot) {
              return snapshot.data != null && snapshot.data!.purchase!.isNotEmpty?
              ListView.builder(
                itemCount: snapshot.data!.purchase!.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (ctx,index){
                    var pure = snapshot.data!.purchase![index];
                 return Card(
                   elevation: 3,
                   color: greyOpacity,
                   child: ListTile(
                     title: header(pure.knetStatuse == 1 ? 'Success' : 'Failed'),
                     subtitle: footer(pure.orderNum.toString()),
                   ),
                 );
              }) : Center(child: footer('You didn\'t do any purchases yet'));
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
}
