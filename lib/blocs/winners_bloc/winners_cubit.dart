import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/winners_bloc/winners_state.dart';
import 'package:dinarkom/model/winners_model.dart';
import 'package:dinarkom/repositories/winners_repo.dart';

class WinnersCubit extends Cubit<WinnersState>{
  final WinnersRepo? winnersRepo;

  WinnersCubit({this.winnersRepo}) : super(WinnersInitial());

  List<WinnersModel>? _winners;

  void getWinners()async{
    emit(WinnersLoading());
    _winners = await winnersRepo!.loadWinners();

    if(_winners != null){
      emit(WinnersLoaded(_winners));
    }else{
      emit(WinnersLoadFailure());
    }
  }
}