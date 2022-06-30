import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/login_bloc/login_state.dart';
import 'package:dinarkom/model/auth_response_model.dart';
import 'package:dinarkom/model/user_model.dart';
import 'package:dinarkom/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState>{
  final UserRepository? userRepository;
  LoginCubit({this.userRepository}) : super(LoginInitial());

  String? currentToken;
  AppUser? currentUser;

  AppUser get getUser => currentUser!;
  String get getToken => currentToken!;

  void login(String email,String password)async{
    emit(LoadingLogin());
   ResponseModel responseModel = await userRepository!.loginResponse(email, password);
   if(responseModel.appUser!.token != null){
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('authToken', responseModel.appUser!.token!);
     currentToken = responseModel.appUser!.token;
     emit(LoginSuccessful(responseModel.appUser!));
   }else{
     emit(LoginFailed(responseModel.message!));
   }
  }

  Future<bool> logout(String token)async{
    bool result = await userRepository!.logOutResponse(token);
    if(result){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', '');
      currentToken = '';
      currentUser = AppUser();
      emit(LoginInitial());
    }
   return result;
  }

  void getCurrentUser(String token)async{
    ResponseModel responseModel = await userRepository!.getUser(token);
    if(responseModel.appUser!.id != null){
      debugPrint('name = ' + responseModel.appUser!.name!);
      currentUser = responseModel.appUser;
      currentToken = responseModel.appUser!.token;
    }
  }

}