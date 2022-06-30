import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/digital_photo_bloc/digital_photo_state.dart';
import 'package:dinarkom/model/digital_photo_model.dart';
import 'package:dinarkom/repositories/digital_photo_repo.dart';

class DigitalCubit extends Cubit<DigitalPhotoState>{
  final DigitalPhotoRepo? digitalPhotoRepo;

  DigitalCubit({this.digitalPhotoRepo}) : super(DigitalInitial());

  DigitalPhoto? _currentDigital;

  void getCurrentDigitalInfo()async{
    emit(DigitalLoading());
    _currentDigital =   await digitalPhotoRepo!.loadDigitalPhoto();
    if(_currentDigital != null){
      emit(DigitalLoaded(_currentDigital));
    }else{
      emit(DigitalLoadFailure());
    }
  }
}