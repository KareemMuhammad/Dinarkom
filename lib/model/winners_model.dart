import 'package:flutter/foundation.dart';

class WinnersModel{
  final int? id;
  final int? imageId;
  final int? userId;
  final int? orderId;
  final String? prize;
  final String? winnerName;

  WinnersModel({@required this.winnerName, @required this.prize, @required this.id,@required this.imageId,
    @required this.orderId,@required this.userId,});


  factory WinnersModel.fromJson(Map<String, dynamic> json) {
    return WinnersModel(
      id: json['id'] as int,
      imageId: json['imgID'] as int,
      userId: json['userID'] as int,
      orderId: json['orderID'] as int,
      prize: json['prize'] == null ? '0' : json['prize'] as String,
      winnerName: json['name'] as String,
    );
  }
}