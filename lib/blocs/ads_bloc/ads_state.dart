import 'package:dinarkom/model/ads_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AdsState{}

class AdsInitial extends AdsState{}

class AdsLoading extends AdsState{}

class AdsLoadFailure extends AdsState{}

class AdsLoaded extends AdsState{
  final AdsModel? adsModel;

  AdsLoaded(this.adsModel);
}