
import 'package:cached_network_image/cached_network_image.dart';
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

  //late Future<PurchaseModel> getPurchases;
  late List<Purchase> purchaseList = [];

  @override
  void initState() {
    debugPrint(widget.token);
    Future.microtask(() async{
     PurchaseModel model = await PaymentRepo().getMyPurchases(widget.token);
     purchaseList = model.purchase!;
     if(mounted) setState(() {});
    });
   // getPurchases = PaymentRepo().getMyPurchases(widget.token);
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
          PurchaseModel model = await PaymentRepo().getMyPurchases(widget.token);
          setState(() {
        //    getPurchases = PaymentRepo().getMyPurchases(widget.token);

            purchaseList = model.purchase!;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: purchaseList.isNotEmpty?
              ListView.builder(
                itemCount: purchaseList.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (ctx,index){
                    var pure = purchaseList[index];
                 return Card(
                   elevation: 3,
                   color: greyOpacity,
                   child: ListTile(
                     leading: CachedNetworkImage(imageUrl: pure.image!,),
                     title: footer(pure.orderNum.toString()),
                     subtitle: footer(pure.orderDate!),
                   ),
                 );
              }) : Center(child: Column(
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                  Image.asset('assets/empty.png',
                    height: SizeConfig.blockSizeVertical! * 25,
                    width: SizeConfig.blockSizeVertical! * 25,),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
                  footer('${Utils.getTranslatedText(context,'purchases_hint')}'),
                ],
              )),

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
