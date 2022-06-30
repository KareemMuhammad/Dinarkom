import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/ads_bloc/ads_state.dart';
import 'package:dinarkom/model/ads_model.dart';
import 'package:dinarkom/repositories/ads_repo.dart';

class AdsCubit extends Cubit<AdsState>{
  final AdsRepo? adsRepo;
  AdsCubit({this.adsRepo}) : super(AdsInitial());

  AdsModel? adsModel;

  void getAdsModel()async{
    emit(AdsLoading());
    List list = await adsRepo!.loadAds();
    adsModel = list.first;
    if(adsModel != null){
      emit(AdsLoaded(adsModel));
    }else{
      emit(AdsLoadFailure());
    }
  }
}