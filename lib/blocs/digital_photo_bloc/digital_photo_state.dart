import 'package:dinarkom/model/digital_photo_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DigitalPhotoState{}

class DigitalInitial extends DigitalPhotoState{}

class DigitalLoading extends DigitalPhotoState{}

class DigitalLoadFailure extends DigitalPhotoState{}

class DigitalLoaded extends DigitalPhotoState{
  final DigitalPhoto? digitalPhoto;

  DigitalLoaded(this.digitalPhoto);
}