class AvailableModel {

  String? name;
  String? uri;
  String? image;

  AvailableModel({ this.image, this.name, this.uri });

  AvailableModel.fromJson(Map<String, dynamic> json){
      image = json['image'];
      name = json['name'];
      uri  = json['uri'];
  }

  Map<String, dynamic> toJson() => {'image':image, 'name':name, 'uri':uri };
}
