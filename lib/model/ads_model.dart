import 'package:dinarkom/utils/constants.dart';
import 'package:flutter/foundation.dart';

class AdsModel{
  final int? id;
  final String? leftImage;
  final String? rightImage;
  final String? urlRight;
  final String? urlLeft;

  AdsModel({@required this.urlRight,@required this.urlLeft, @required this.id,
    @required this.leftImage, @required this.rightImage,});


  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'] as int,
      leftImage: Utils.assetsUtil + json['LeftImage'],
      rightImage: Utils.assetsUtil + json['rightImage'],
      urlLeft: json['urlLeft'] as String,
      urlRight: json['urlRight'] as String,
    );
  }
}