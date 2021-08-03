class Store {
  String? id, name, location, storageClass;

  Store.fromJson(Map json)
      : id = json["id"],
        name = json["name"],
        location = json["location"],
        storageClass = json["storageClass"];
}
