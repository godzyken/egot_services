import 'dart:async';

import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef FirebaseListener = void Function(QuerySnapshot snapshot);
typedef FirebaseDocumentStreamListener = void Function(
    DocumentSnapshot snapshot);

class FirebaseManager {
  FirebaseFirestore? firestore;
  Geoflutterfire? geo;
  WebSocketChannel? webSocketChannel;
  CollectionReference<Map<String, dynamic>>? anchorCollection;
  CollectionReference<Map<String, dynamic>>? objectCollection;
  CollectionReference<Map<String, dynamic>>? modelCollection;
  CollectionReference<Map<String, dynamic>>? channelCollection;

  // Firebase initialization function
  Future<bool> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize
      geo = Geoflutterfire();
      firestore = FirebaseFirestore.instance;
      anchorCollection = firestore!.collection('anchors');
      objectCollection = firestore!.collection('objects');
      modelCollection = firestore!.collection('models');
      channelCollection = firestore!.collection('channels');

      return true;
    } on FirebaseException catch (code, message) {
      print('initializeFlutterFire error code: $code\n');
      print('firebase error message: $message\n');
      return false;
    }
  }

  void uploadAnchor(ARAnchor anchor, {Position? currentLocation}) {
    if (firestore == null) return;

    var serializedAnchor = anchor.toJson();
    var expirationTime = DateTime.now().millisecondsSinceEpoch / 1000 +
        serializedAnchor["ttl"] * 24 * 60 * 60;
    serializedAnchor["expirationTime"] = expirationTime;
    // Add location
    if (currentLocation != null) {
      GeoFirePoint myLocation = geo!.point(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
      serializedAnchor["position"] = myLocation.data;
    }

    anchorCollection!
        .add(serializedAnchor)
        .then((value) =>
            print("Successfully added anchor: " + serializedAnchor["name"]))
        .catchError((error) => print("Failed to add anchor: $error"));
  }

  void uploadObject(ARNode node) {
    if (firestore == null) return;

    var serializedNode = node.toMap();

    objectCollection!
        .add(serializedNode)
        .then((value) =>
            print("Successfully added object: " + serializedNode["name"]))
        .catchError((error) => print("Failed to add object: $error"));
  }

  void downloadLatestAnchor(FirebaseListener listener) {
    anchorCollection!
        .orderBy("expirationTime", descending: false)
        .limitToLast(1)
        .get()
        .then((value) => listener(value))
        .catchError(
            (error) => (error) => print("Failed to download anchor: $error"));
  }

  void downloadAnchorsByLocation(FirebaseDocumentStreamListener listener,
      Position location, double radius) {
    GeoFirePoint center =
        geo!.point(latitude: location.latitude, longitude: location.longitude);

    Stream<List<DocumentSnapshot>> stream = geo!
        .collection(collectionRef: anchorCollection!)
        .within(center: center, radius: radius, field: 'position');

    stream.listen((List<DocumentSnapshot> documentList) {
      for (var element in documentList) {
        listener(element);
      }
    });
  }

  void downloadAnchorsByChannel(FirebaseDocumentStreamListener? listener,
      IOWebSocketChannel? channel, ARUnkownAnchor? anchorFromJson) {
    webSocketChannel!.sink.addStream(channel!.stream);
  }

  void getObjectsFromAnchor(ARPlaneAnchor? anchor, FirebaseListener? listener) {
    objectCollection!
        .where("name", whereIn: anchor?.childNodes)
        .get()
        .then((value) => listener!(value))
        .catchError((error) => print("Failed to download objects: $error"));
  }

  void deleteExpiredDatabaseEntries() {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    anchorCollection!
        .where("expirationTime",
            isLessThan: DateTime.now().millisecondsSinceEpoch / 1000)
        .get()
        .then((anchorSnapshot) {
      for (var anchorDoc in anchorSnapshot.docs) {
        objectCollection!
            .where("name", arrayContainsAny: anchorDoc.get("childNodes"))
            .get()
            .then((objectSnapshot) {
          for (var objectDoc in objectSnapshot.docs) {
            batch.delete(objectDoc.reference);
          }
        });

        // Delete the expired anchor
        batch.delete(anchorDoc.reference);
      }
    });
    batch.commit();
  }

  void downloadAvailableModels(FirebaseListener listener) {
    modelCollection!
        .get()
        .then((value) => listener(value))
        .catchError((error) => print("Failed to download objects: $error"));
  }
}
