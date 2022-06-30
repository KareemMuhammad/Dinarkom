import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/about_bloc/about_state.dart';
import 'package:dinarkom/model/about_model.dart';
import 'package:dinarkom/service/about_service.dart';

class AboutCubit extends Cubit<AboutState>{
  final AboutService? aboutService;

  AboutCubit({this.aboutService}) : super(AboutInitial());

  List<AboutModel>? aboutList;

  void getCurrentAboutLang(String local)async{
    emit(AboutLoading());
    aboutList = await aboutService!.getAboutLanguage(local);
    if(aboutList != null){
      emit(AboutLoaded(aboutList));
    }else{
      emit(AboutLoadFailure());
    }
  }
}