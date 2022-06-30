import 'package:flutter/material.dart';

@immutable
abstract class BarState {
  final int index;

  const BarState(this.index);
}

class CurrentIndex extends BarState{

 const CurrentIndex(int index) : super (index);
}