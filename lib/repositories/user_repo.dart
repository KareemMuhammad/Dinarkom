import 'dart:convert';
import 'package:dinarkom/model/auth_response_model.dart';
import 'package:dinarkom/model/relevant_model.dart';
import 'package:dinarkom/model/user_model.dart';
import 'package:dinarkom/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class UserRepository{
  final UserHttpService _userHttpService = UserHttpService();

  Future<ResponseModel> loginResponse(String email,String password)async{
   Response response = await _userHttpService.loginService(email, password);
   if(response.statusCode == 200){
     if(jsonDecode(response.body)['user'] != null) {
       return ResponseModel(
           appUser: AppUser.fromJson(jsonDecode(response.body)['user']),
           message: jsonDecode(response.body)['message']);
     }else{
       return ResponseModel(
           appUser: AppUser(),
           message: jsonDecode(response.body)['message']);
     }
   }else{
     return ResponseModel(appUser: AppUser(),
         message: 'Error in server');
   }
  }

  Future<ResponseModel> signUpResponse(String name, String email,
      String phone,String anotherPhone, String password,
      String nationalId,String confirm)async{

    Response response = await _userHttpService.
    signUpService(name,email,phone,anotherPhone,
    password,nationalId,confirm);
    debugPrint(response.statusCode.toString());

    if(response.statusCode == 200){
      if(jsonDecode(response.body)['user'] != null) {
        return ResponseModel(
            appUser: AppUser.fromJson(jsonDecode(response.body)['user']),
            message: jsonDecode(response.body)['message']);
      }else{
        return ResponseModel(
            appUser: AppUser(),
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return ResponseModel(appUser: AppUser(),
          message: 'Error in server');
    }
  }

  Future<bool> logOutResponse(String token)async{
   Response response = await _userHttpService.logoutService(token);
   if(response.statusCode == 200){
     debugPrint(jsonDecode(response.body).toString());
     return jsonDecode(response.body)['status'];
   }else{
     return false;
   }
  }

  Future<ResponseModel> getUser(String token)async{
    Response response = await _userHttpService.getUserByID(token);
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['user'] != null) {
        return ResponseModel(
            appUser: AppUser.fromJson(jsonDecode(response.body)['user']),
            message: jsonDecode(response.body)['message']);
      }else{
        return ResponseModel(
            appUser: AppUser(),
            message: jsonDecode(response.body)['message']);
      }
    }else{
      return ResponseModel(appUser: AppUser(),
          message: 'Error in server');
    }
  }

  Future<RelevantModel> getMyRelevant(String token)async{
    Response response = await _userHttpService.getRelevant(token);
    if(response.statusCode == 200){
        return RelevantModel.fromJson(jsonDecode(response.body));
    }else{
      return RelevantModel();
    }
  }

}