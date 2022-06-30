import 'package:dinarkom/model/winners_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WinnersState{}

class WinnersInitial extends WinnersState{}

class WinnersLoading extends WinnersState{}

class WinnersLoadFailure extends WinnersState{}

class WinnersLoaded extends WinnersState{
  final List<WinnersModel>? winnersList;

  WinnersLoaded(this.winnersList);
}