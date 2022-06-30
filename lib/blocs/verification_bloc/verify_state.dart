import 'package:flutter/material.dart';

@immutable
abstract class VerifyState {
  final bool isVerified;

  const VerifyState(this.isVerified);
}

class CurrentVerification extends VerifyState{

  const CurrentVerification(bool isVerify) : super (isVerify);
}