import 'package:dinarkom/service/base_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class UserHttpService extends BaseAPI{

  Future<Response> loginService(String email,String password)async{
    try {

      Response response = await post(
          Uri.parse(super.loginPath + 'email=$email&' + 'password=$password&')
          ,headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> signUpService(String name, String email,
      String phone,String anotherPhone,
      String password,String nationalId,String confirmPass) async {
    try {

      Response response = anotherPhone.isEmpty? await post(Uri.parse(
          super.registrationPath + 'name=$name&' + 'email=$email&' +
              'civilID=$nationalId&' + 'phone=$phone&' + 'password=$password&'
       + 'password_confirmation=$confirmPass')) :
      await post(Uri.parse(super.registrationPath + 'name=$name&'
          + 'email=$email&' + 'civilID=$nationalId&' + 'phone=$phone&' +
          'anotherPhone=$anotherPhone&' + 'password=$password&'
          + 'password_confirmation=$confirmPass'));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> logoutService(String token)async{
    try {

      Response response = await post(Uri.parse(super.logoutPath +
          'auth_token=$token'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> resetPasswordService(String email)async{
    try {

      Response response = await post(Uri.parse(super.resetPassword +
          'email=$email'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> updateUserDetails(String name, String email,
      String token, String phone,
      String password,String confirmPass,int civilId)async{
    try {

      Response response = await post(Uri.parse(super.updateUserPath +
          'auth_token=$token&'+
          'name=$name&' + 'email=$email&' + 'phone=$phone&'
          + 'password=$password&' + 'password_confirmation=$confirmPass&' +
      'civilId=$civilId'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getUserByID(String id)async{
    try {

      Response response = await post(Uri.parse(super.getUserById +
          'auth_token=$id'),
          headers: super.headers);

      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> addRelevant(String name,String token,
      String civilId,String relation)async{
    try {

      Response response = await post(Uri.parse(super.addRelativePath +
          'name=$name&' + 'auth_token=$token&' + 'civilId=$civilId&' +
          'relation=$relation'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> getRelevant(String token)async{
    try {

      Response response = await post(Uri.parse(super.getRelativesPath +
          'auth_token=$token&'),
          headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

  Future<Response> updateRelevant(String token,String name,
      String civilId,String relation,int relativeId)async{
    try {

      Response response = await post(Uri.parse(super.updateRelativePath +
          'auth_token=$token&' + 'name=$name&' + 'auth_token=$token&'
          + 'civilId=$civilId&' + 'relation=$relation&' +
          'relativeId=$relativeId'), headers: super.headers);
      return response;
    }catch(e){
      debugPrint(e.toString());
      return Response('', 404);
    }
  }

}