import 'package:dinarkom/model/user_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoadingLogin extends LoginState{}

class LoginSuccessful extends LoginState{
  final AppUser appUser;

  LoginSuccessful(this.appUser);
}

class LoginFailed extends LoginState{
  final String message;

  LoginFailed(this.message);
}


