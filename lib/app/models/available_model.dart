import 'package:get/get.dart';

class RxAvailableModel {
  final name = 'santa maria madalena'.obs;
  final uri =
      'https://github.com/godzyken/egot_services/blob/master/assets/lottie/models/santa_maria_madalena/scene.gltf'
          .obs;
  final image = 'assets/lottie/models/santa_maria_madalena/scene.gltf'.obs;
}

class AvailableModel {
  AvailableModel({image, name, uri});
  final rx = RxAvailableModel();

  get image => rx.image.value;
  set image(value) => rx.image.value = value;

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get uri => rx.uri.value;
  set uri(value) => rx.uri.value = value;

  AvailableModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() => {'image': image, 'name': name, 'uri': uri};
}
