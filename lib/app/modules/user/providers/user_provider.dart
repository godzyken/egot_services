import 'package:flutter/foundation.dart';

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:getxfire/getxfire.dart';

class UserProvider extends GetConnect {
  final FirestoreService _service = FirestoreService();

  final _userList = <UserModel>[].obs;

  var collection = 'users';

  var data = UserModel().toJson();

  Future<bool> createNewUser(UserModel? userModel) async{
    try {
      await _service.createData(
          collection: collection,
          data: data
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async{
    try {
      DocumentSnapshot doc = await _service.getDetail(
          collection: collection, id: uid!
      );

      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsers() async{
    try {
      List<DocumentSnapshot> docs = await _service.getData(collection: collection);

      return _userList.stream.elementAt(docs.length.sign);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      rethrow;
    }
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserModel.fromJson(map);
      if (map is List) {
        return map.map((item) => UserModel.fromJson(item)).toList();
      }
    };
    httpClient.addRequestModifier<void>((request) {
      request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      return request;
    });
    // httpClient.baseUrl = 'YOUR-API-URL';
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  // Future<UserModel> getUser(int? id) async {
  //   final response = await get('users/$id');
  //   return response.body;
  // }
  //
  // //TODO: link with firebase
  // Future<Response<List<UserModel>>> getAllUsers() =>
  //     get<List<UserModel>>('https://console.firebase.google.com/project/egoteback/authentication/users?hl=fr', decoder: UserModel.listFromJson);
  //
  // Future<Response<UserModel>> postUser(UserModel user) async =>
  //     await post('users', user);
  //
  // Future<Response> deleteUser(int id) async => await delete('users/$id');
}
