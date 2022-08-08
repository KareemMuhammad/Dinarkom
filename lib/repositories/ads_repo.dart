import 'dart:convert';
import 'package:dinarkom/model/ads_model.dart';
import 'package:dinarkom/service/ads_service.dart';
import 'package:http/http.dart';

class AdsRepo{
  final AdsService _adsService = AdsService();

  Future<List<AdsModel>> loadAds()async{
   Response response = await _adsService.getAdsPhoto();
   if(response.statusCode == 200){
     List list = jsonDecode(response.body)['images'];
     return list.map((e) => AdsModel.fromJson(e)).toList();
   }else{
     return [];
   }
  }
}