import 'package:dinarkom/utils/constants.dart';
import 'package:flutter/foundation.dart';

class DigitalPhoto{
  final int? id;
  final String? smallPaidImage;
  final int? totalCount;
  final int? totalSales;
  final int? expire;
  final int? imagePrice;

  DigitalPhoto({@required this.imagePrice,
    @required this.id, @required this.smallPaidImage,
   @required this.totalCount,
    @required this.totalSales,@required this.expire});

 const DigitalPhoto.dummy({ @required this.imagePrice, @required this.id,
   @required this.smallPaidImage,@required this.totalCount,
    @required this.totalSales,@required this.expire});

  factory DigitalPhoto.fromJson(Map<String, dynamic> json) {
    return DigitalPhoto(
      id: json['id'] as int,
      smallPaidImage: Utils.assetsUtil + json['paiedImage'],
      totalCount: json['totalSales'] as int,
      totalSales: json['numberSales'] as int,
      expire: json['expire'] as int,
      imagePrice: json['imgPrice'] as int,
    );
  }
}