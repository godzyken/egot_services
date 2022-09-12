import 'dart:async';
import 'dart:io';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:egot_services/app/helpers/firebase_manager.dart';
import 'package:egot_services/app/models/available_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../../../socket_channel.dart';

class ArchivesController extends GetxController {
  final _platformVersion = 'Unknown'.obs;
  Map<String, Map> anchorsInDownloadProgress = <String, Map>{};
  Map<String, Map> arNodeInDownloadProgress = <String, Map>{};
  var initialize = false.obs;
  var error = false.obs;
  var readyToUpload = false.obs;
  var readyToDownload = false.obs;
  var modelChoiceActive = false.obs;
  var didAddNodeToAnchor = false.obs;
  var didAddAnchor = false.obs;
  var anchorWasFound = false.obs;
  var firebaseManager = FirebaseManager();
  var urlSketch = 'https://app.sketchup.com/app';
  var nodes = <ARNode>[];
  var anchors = <ARAnchor>[];
  var lastUploadedAnchor = "".obs;
  var selectedModel = AvailableModel().obs;

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  ARNode? localObjectNode;
  Timer? timer;
  IOWebSocketChannel? webSocketChannel;
  StreamSubscription? getSubscription;

  String? objectSelected;
  WebSocket? webSocket;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
    arSessionManager?.snapshot();
    getSubscription?.cancel();

    webSocketChannel = IOWebSocketChannel.connect(
        Uri.parse('wss://socketsbay.com/wss/v2/$apikey/'));
    // IOWebSocketChannel.connect('wss://socketsbay.com/wss/v2/2/egotservices/');

    firebaseManager.initializeFlutterFire().then((value) {
      initialize.value = !value;
      error.value = !value;
      getSubscription = webSocketChannel!.stream.listen((message) {
        // Is never fired?
        if (kDebugMode) {
          print("Got live message");
          print(message);
        }
        webSocketChannel!.sink.add('received!');
        webSocketChannel!.sink.close(status.goingAway);
      })
        ..onData((data) {
          if (kDebugMode) {
            print("onData - WebSocket");
            print(data);
          }
        })
        ..onDone(() {
          if (kDebugMode) {
            print("onDone - WebSocket");
          }
        })
        ..onError((e) {
          if (kDebugMode) {
            print("onError - WebSocket");
            print(error.value);
          }
        });
    });

    update();
    arSessionManager?.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    webSocketChannel!.sink.close();
    arSessionManager!.dispose();
  }

  @override
  void onReady() {
    onARViewCreated(
        arSessionManager, arObjectManager, arAnchorManager, arLocationManager);

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    arSessionManager?.dispose();
  }

  Future<String> initPlatformState() async {
    String? platformVersion;
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
      webSocketChannel!.sink.add;
    } on PlatformException {
      platformVersion = "Failed to get platform version.";
    }

    return _platformVersion.value = platformVersion;
  }

  void testWebSocket() async {
    Stream stream = IOWebSocketChannel(webSocket!).stream;
    stream.listen((event) {
      for (var ev in event) {
        return print('ques paso: $ev');
      }
    });
    var ws = webSocketChannel!.sink.addStream(stream);
    print('Comment ta : $ws');
  }

  onARViewCreated(
    ARSessionManager? arSessionManager,
    ARObjectManager? arObjectManager,
    ARAnchorManager? arAnchorManager,
    ARLocationManager? arLocationManager,
  ) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    this.arLocationManager = arLocationManager;

    this.arSessionManager?.onInitialize(
        showFeaturePoints: false,
        showPlanes: true,
        handleRotation: true,
        customPlaneTexturePath: "assets/lottie/image/triangle.png",
        showWorldOrigin: true,
        showAnimatedGuide: true);

    this.arObjectManager?.onInitialize();
    this.arAnchorManager?.initGoogleCloudAnchorMode();

    this.arSessionManager?.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arSessionManager?.planeDetectionConfig;

    this.arObjectManager?.onNodeTap = onNodeTapped;
    this.arAnchorManager?.onAnchorUploaded = onAnchorUploaded;
    this.arAnchorManager?.onAnchorDownloaded = onAnchorDownloaded;

    this
        .arLocationManager
        ?.startLocationUpdates()
        .then((value) => value ? null : !value)
        .onError((error, _) {
      switch (error.toString()) {
        case 'Location services disabled':
          {
            showAlertDialog(
                "Action Required",
                "To use cloud anchor functionality, please enable your location services",
                "Settings",
                this.arLocationManager!.openLocationServicesSettings,
                "Cancel");
            break;
          }

        case 'Location permissions denied':
          {
            debugPrint("");
            break;
          }

        case 'Location permissions permanently denied':
          {
            debugPrint("");
            break;
          }

        default:
          {
            this.arSessionManager!.onError(error.toString());
            break;
          }
      }
      arSessionManager!.onError(error.toString());
      arSessionManager.dispose();
      return null;
    });

    update();
  }

  void onModelSelected(AvailableModel? model) {
    selectedModel.value = model!;
    arSessionManager!.onError(model.name! + " selected");

    modelChoiceActive.value = false;
  }

  Future<void> onRemoveEverythinh() async {
    for (var anchor in anchors) {
      arAnchorManager!.removeAnchor(anchor);
    }
    anchors = [];
    if (lastUploadedAnchor.isNotEmpty) {
      readyToDownload.value = true;
      readyToUpload.value = false;

      update();
    } else {
      readyToDownload.value = true;
      readyToUpload.value = false;
    }
  }

  Future<void> onNodeTapped(List<String> nodeNames) async {
    var foregroundNode =
        nodes.firstWhere((element) => element.name == nodeNames.first);

    arSessionManager!.onError(foregroundNode.data!["onTapText"]);

    update();
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

    var newAnchor = ARPlaneAnchor(
        transformation: singleHitTestResult.worldTransform, ttl: 2);
    didAddAnchor.value = (await arAnchorManager!.addAnchor(newAnchor))!;

    if (didAddAnchor.isTrue) {
      anchors.add(newAnchor);

      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: selectedModel.value.uri!,
          scale: vector_math.Vector3(0.2, 0.2, 0.2),
          position: vector_math.Vector3(0.0, 0.0, 0.0),
          rotation: vector_math.Vector4(1.0, 0.0, 0.0, 0.0),
          data: {"onTapText": "I am a " + selectedModel.value.name!});

      didAddNodeToAnchor.value =
          (await arObjectManager!.addNode(newNode, planeAnchor: newAnchor))!;

      if (didAddNodeToAnchor.isTrue) {
        nodes.add(newNode);
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
      readyToUpload.value = true;

      update();
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  Future<void> onUploadButtonPressed() async {
    arAnchorManager!.uploadAnchor(anchors.last);
    readyToUpload.value = false;
  }

  onAnchorUploaded(ARAnchor anchor) {
    firebaseManager.uploadAnchor(anchor,
        currentLocation: arLocationManager!.currentLocation);
    if (anchor is ARPlaneAnchor) {
      for (var nodeName in anchor.childNodes) {
        firebaseManager.uploadObject(
            nodes.firstWhere((element) => element.name == nodeName));

        update();
      }
    }
    readyToDownload.value = true;
    readyToUpload.value = false;

    arSessionManager!.onError("Upload successful");
  }

  ARAnchor onAnchorDownloaded(Map<String, dynamic> serializedAnchor) {
    final anchor = ARPlaneAnchor.fromJson(anchorsInDownloadProgress);
    anchorsInDownloadProgress.remove(anchor.cloudanchorid);
    anchors.add(anchor);

    firebaseManager.getObjectsFromAnchor(anchor, (snapshot) {
      for (var objectDoc in snapshot.docs) {
        arNodeInDownloadProgress.containsValue(objectDoc.data());

        var object = ARNode.fromMap(arNodeInDownloadProgress);
        arObjectManager!.addNode(object, planeAnchor: anchor);
        nodes.add(object);

        update();
      }
    });

    return anchor;
  }

  Future<void> onDownloadButtonPressed() async {
    if (arLocationManager!.currentLocation != null) {
      firebaseManager.downloadAnchorsByLocation((snapshot) {
        final cloudAnchorId = snapshot.get("cloudanchorid");
        // anchorsInDownloadProgress![cloudAnchorId] = snapshot.data();
        arAnchorManager!.downloadAnchor(cloudAnchorId);
      }, arLocationManager!.currentLocation, 0.1);
      readyToDownload.value = false;

      update();
    } else {
      arSessionManager!
          .onError("Location updates not running, can't download anchors");
    }
  }

  void showAlertDialog(String title, String content, String buttonText,
      Function buttonFunction, String cancelButtonText) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text(cancelButtonText),
      onPressed: () {
        GetNavigator(
          pages: const [],
        ).onPopPage;
      },
    );
    Widget actionButton = ElevatedButton(
      child: Text(buttonText),
      onPressed: () {
        buttonFunction();
        GetNavigator(
          pages: const [],
        ).onPopPage;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        actionButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (_) {
        return alert;
      },
    );
  }

  Future<void> onLocalObjectAtOriginButtonPressed() async {
    if (localObjectNode != null) {
      arObjectManager!.removeNode(localObjectNode!);
      localObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/lottie/models/santa_maria_madalena/scene.gltf",
          scale: vector_math.Vector3(0.2, 0.2, 0.2),
          position: vector_math.Vector3(0.0, 0.0, 0.0),
          rotation: vector_math.Vector4(1.0, 0.0, 0.0, 0.0));

      didAddAnchor.value = (await arObjectManager?.addNode(newNode))!;
      localObjectNode = (didAddAnchor.value) ? newNode : null;
    }
  }
}
