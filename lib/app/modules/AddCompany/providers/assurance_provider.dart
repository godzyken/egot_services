import 'package:get/get.dart';

import '../../../models/assurance_model.dart';

class AssuranceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Assurance.fromJson(map);
      if (map is List)
        return map.map((item) => Assurance.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
   // 'AIzaSyAypBObLlTSZAeu8gs7Km3pWW-RCxk7ywc';
   //'https://www.google.com/search?q=assurance+entreprise&rlz=1C1ONGR_frFR934FR934&oq=assurance+entreprise&aqs=chrome..69i57j69i59l2j0i20i263i512j0i512l2j69i60l2.12994j0j4&sourceid=chrome&ie=UTF-8';
  }

  Future<Assurance?> getAssurance(int id) async {
    final response = await get('assurance/$id');
    return response.body;
  }

  Future<Response<List<Assurance>>> getAllAssurance() async =>
      await get('?brand=assurance+entreprise');

  Future<Response<Assurance>> postAssurance(Assurance assurance) async =>
      await post('assurance', assurance);

  Future<Response> deleteAssurance(int id) async =>
      await delete('assurance/$id');
}
