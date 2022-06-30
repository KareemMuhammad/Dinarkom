import 'package:flutter/material.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState{}

class UserLoading extends UserState{}