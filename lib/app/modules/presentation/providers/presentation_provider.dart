import 'dart:async';

import 'package:egot_services/app/models/store_model.dart';
import 'package:egot_services/app/modules/presentation/services/base_service_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class IPresentationProvider {
  FutureOr<Response<Store?>> getNews();
}
class PresentationProvider extends BaseServiceProvider implements IPresentationProvider {
  @override
  void onInit() {
    super.onInit();

    getNews();
    getPersonData();
  }

  /// for get requests.
  FutureOr<Store> getPersonData() async {
    var res = await get("/person_url");
    debugPrint(res.body!);
    return res.body!;
  }
  /// for post requests.
  FutureOr<Store> postPersonData(dynamic body) async {
    var res = await post("/person_url", body);
    print(res);
    return res.body;
  }
  /// for put requests.
  FutureOr<Store> putPersonData(dynamic body) async {
    var res = await put("/person_url", body);
    print(res);
    return res.body;
  }
  /// for delete requests.
  FutureOr<Store> deletePersonData() async {
    var res = await delete("/person_url");
    print(res);
    return res.body;
  }

  @override
  FutureOr<Response<Store>> getNews() async {
    var response = await get("/storage");
    var data = Store.fromJson(response.body!);
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: data,
    );
  }
}
