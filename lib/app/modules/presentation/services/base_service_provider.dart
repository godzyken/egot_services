import 'package:get/get.dart';

import 'package:egot_services/app/models/store_model.dart';

class BaseServiceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (data) => Store.fromJson(data);
    httpClient.baseUrl = 'http://192.168.1.12:3000';
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);
    httpClient.addRequestModifier<void>((request) {
      request.headers['apikey'] = '12345678';
      return request;
    });

    httpClient.addResponseModifier<dynamic>((request, response) {
      final Store? model = response.body;
      if (model!.id != null) {
        model.id!.compareTo('id');
      }
    });

    httpClient.addAuthenticator<void>((request) async {
      final response = await get("http://yourapi/token");
      final token = response.body['token'];

      request.headers['Authorization'] = "$token";
      return request;
    });

    httpClient.maxAuthRetries = 3;
  }

  @override
  void onClose() {}

  @override
  void onReady() {}
}
