class RxModel {
  final name= 'santa maria madalena';
  final uri= 'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb';
  final image= 'assets/lottie/models/santa_maria_madalena/scene.gltf';
}

class AvailableModel {
  String? name;
  String? uri;
  String? image;

  AvailableModel({this.image, this.name, this.uri});

  AvailableModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() => {'image': image, 'name': name, 'uri': uri};
}
