import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/bar_bloc/bar_state.dart';

class BarCubit extends Cubit<BarState>{
  BarCubit() : super(const CurrentIndex(2));

  int? _index = 2;

  int get index => _index!;

  set index(int value) {
    _index = value;
    emit(CurrentIndex(index));
  }
}