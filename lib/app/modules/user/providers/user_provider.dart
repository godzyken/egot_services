import 'package:get/get.dart';

import 'package:egot_services/app/models/use_x_models.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserModel.fromJson(map);
      if (map is List)
        return map.map((item) => UserModel.fromJson(item)).toList();
    };
    httpClient.addRequestModifier<void>((request) {
      request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      return request;
    });
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserModel> getUser(int? id) async {
    final response = await get('users/$id');
    return response.body;
  }

  //TODO: link with firebase
  Future<Response<List<UserModel>>> getAllUsers() =>
      get<List<UserModel>>('https://', decoder: UserModel.listFromJson);

  Future<Response<UserModel>> postUser(UserModel user) async =>
      await post('users', user);
  Future<Response> deleteUser(int id) async => await delete('users/$id');
}
