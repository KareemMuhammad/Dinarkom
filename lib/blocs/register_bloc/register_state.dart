import 'package:flutter/material.dart';

import '../../model/user_model.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState{}

class LoadingRegistration extends RegisterState{}

class RegisterSuccessful extends RegisterState{
  final AppUser appUser;
  final String message;
  RegisterSuccessful(this.appUser, this.message);
}

class RegisterFailed extends RegisterState{
  final String message;

  RegisterFailed(this.message);
}