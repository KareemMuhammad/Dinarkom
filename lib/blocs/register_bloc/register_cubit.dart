import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/register_bloc/register_state.dart';
import 'package:dinarkom/model/auth_response_model.dart';
import 'package:dinarkom/repositories/user_repo.dart';

class RegisterCubit extends Cubit<RegisterState>{
  final UserRepository? userRepository;
  RegisterCubit({this.userRepository}) : super(RegisterInitial());

  void signUp(String name, String email, String phone,String anotherPhone,
      String password,String nationalId,String confirm)async{
    emit(LoadingRegistration());
    ResponseModel responseModel =  await userRepository!.signUpResponse(
        name,email,phone, anotherPhone, password,nationalId,confirm);
    if(responseModel.message!.contains('mail')){
      emit(RegisterSuccessful(responseModel.appUser!,responseModel.message!));
    }else{
      emit(RegisterFailed(responseModel.message!));
    }
  }
}