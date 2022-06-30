import 'dart:convert';
import 'package:dinarkom/model/digital_photo_model.dart';
import 'package:dinarkom/service/digital_photo_service.dart';
import 'package:http/http.dart';
import '../utils/constants.dart';

class DigitalPhotoRepo{
  final DigitalPhotoService _digitalPhotoService = DigitalPhotoService();

  Future<DigitalPhoto> loadDigitalPhoto()async{
   Response response = await _digitalPhotoService.getDigitalPhoto();
   if(jsonDecode(response.body)['status'] == true){
     return DigitalPhoto.fromJson(jsonDecode(response.body)['image']);
   }else{
     return DigitalPhoto();
   }
  }
}