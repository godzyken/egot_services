import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect implements GetxService {
  final RegisterServices _service = RegisterServices();

  final _userList = <UserModel>[].obs;

  var collection = 'users';

  var data = UserModel().toJson();

  List<GetSocket> get socketsList => sockets.toList();

  Future<bool?> createNewUser(UserModel? userModel) async {
    try {
      return await _service.createNewUser(userModel);
      /* return await _service.createData(
          collection: collection,
          data: data,
          id: userModel?.id,
          onError: (message) {
            if (kDebugMode) {
              print(message);
            }
          },
          isErrorDialog: true);*/
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      return await _service.getUser(uid);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<List<QuerySnapshot<Object?>>> getAllUsers() async {
    try {
      return await _service.readUsers().toList();
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
    _userList.listenAndPump((event) {},
        onError: (e) => debugPrint(e),
        cancelOnError: true,
        onDone: () => _userList.reduce(
            (previousValue, element) => compteUser(previousValue, element)));
  }

  @override
  List<GetSocket> get sockets {
    return socketsList;
  }

  compteUser(UserModel previousValue, UserModel element) {
    if (element.id == previousValue.id) {
      return previousValue.id;
    } else {
      for (var nbUsers in _userList) {
        if (previousValue.tenantId == nbUsers.tenantId) {}
        return nbUsers.id;
      }
      return;
    }
  }

/*  @override
  Future<Response<T>> post(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
//
  }*/

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
