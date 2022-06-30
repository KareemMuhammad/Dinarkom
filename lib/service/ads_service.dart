import 'package:dinarkom/service/base_api.dart';
import 'package:http/http.dart';

class AdsService extends BaseAPI{
  Future<Response> getAdsPhoto()async{
    try {
      Response response = await get(Uri.parse(super.adsPath));
      return response;
    }catch(e){
      print(e.toString());
      return Response('', 404);
    }
  }
}