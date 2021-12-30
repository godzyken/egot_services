import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:vector_math/vector_math_64.dart' as VectorMath;

import 'package:egot_services/app/helpers/firebase_manager.dart';
import 'package:egot_services/app/models/available_model.dart';

class ArchivesController extends GetxController {
  Map<String, Map> anchorsInDownloadProgress = <String, Map>{};
  var error = false;
  var readyToUpload = false;
  var readyToDownload = false;
  var modelChoiceActive = false;
  var firebaseManager = FirebaseManager();
  var _platformVersion;

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;

  var nodes = <ARNode>[];
  var anchors = <ARAnchor>[];
  var lastUploadedAnchor = "".obs;
  var selectedModel = AvailableModel();

  String? objectSelected;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
    firebaseManager.initializeFlutterFire().then((value) {
      error = !value;
    });
  }

  @override
  void onReady() {
    onARViewCreated(
        arSessionManager, arObjectManager, arAnchorManager, arLocationManager);
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> initPlatformState() async {
    String platformVersion = 'Unknown';

    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = "Failed to get platform version.";
    }

    return _platformVersion = platformVersion;
  }

  onARViewCreated(
    ARSessionManager? arSessionManager,
    ARObjectManager? arObjectManager,
    ARAnchorManager? arAnchorManager,
    ARLocationManager? arLocationManager,
  ) {
    arSessionManager = arSessionManager;
    arObjectManager = arObjectManager;
    arAnchorManager = arAnchorManager;
    arLocationManager = arLocationManager;

    arSessionManager!.onInitialize();

    arObjectManager!.onInitialize();
    arAnchorManager!.initGoogleCloudAnchorMode();

    arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
    arObjectManager.onNodeTap = onNodeTapped;
    arAnchorManager.onAnchorUploaded = onAnchorUploaded;
    arAnchorManager.onAnchorDownloaded = onAnchorDownloaded;

/*
    arCoreController.onNodeTap = (nodeNames) => onNodeTapped([]);
    arCoreController.onPlaneTap = onPlaneTapHandler;
*/

    this
        .arLocationManager!
        .startLocationUpdates()
        .then((value) => null)
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
    });
  }

  void onModelSelected(AvailableModel model) {
    selectedModel = model;
    arSessionManager!.onError(model.name! + " selected");

    modelChoiceActive = false;
  }

  Future<void> onRemoveEverythinh() async {
    for (var anchor in anchors) {
      arAnchorManager!.removeAnchor(anchor);
    }
    anchors = [];
    if (lastUploadedAnchor != "") {
      readyToDownload = true;
      readyToUpload = false;
    } else {
      readyToDownload = true;
      readyToUpload = false;
    }
  }

  Future<void> onNodeTapped(List<String> nodeNames) async {
    var foregroundNode =
        nodes.firstWhere((element) => element.name == nodeNames.first);
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

    if (singleHitTestResult != null) {
      var newAnchor = ARPlaneAnchor(
          transformation: singleHitTestResult.worldTransform, ttl: 2);
      bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
      anchors.add(newAnchor);

      var newNode = ARNode(
          type: NodeType.webGLB,
          uri: selectedModel.uri!,
          scale: VectorMath.Vector3(0.2, 0.2, 0.2),
          position: VectorMath.Vector3(0.0, 0.0, 0.0),
          rotation: VectorMath.Vector4(1.0, 0.0, 0.0, 0.0),
          data: {"onTapText": "I am a " + selectedModel.name!});

      bool? didAddNodeToAnchor =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      nodes.add(newNode);
      readyToUpload = true;
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  Future<void> onUploadButtonPressed() async {
    arAnchorManager!.uploadAnchor(anchors.last);
    readyToUpload = false;
  }

  onAnchorUploaded(ARAnchor anchor) {
    firebaseManager.uploadAnchor(anchor,
        currentLocation: arLocationManager!.currentLocation);
    if (anchor is ARPlaneAnchor) {
      for (var nodeName in anchor.childNodes) {
        firebaseManager.uploadObject(
            nodes.firstWhere((element) => element.name == nodeName));
      }
    }
    readyToDownload = true;
    readyToUpload = false;

    arSessionManager!.onError("Upload successful");
  }

  ARAnchor onAnchorDownloaded(Map<String, dynamic> serializedAnchor) {
    final anchor = ARPlaneAnchor.fromJson(anchorsInDownloadProgress);
    anchorsInDownloadProgress.remove(anchor.cloudanchorid);
    anchors.add(anchor);

    /*   firebaseManager.getObjectsFromAnchor(anchor, (snapshot) {
      for (var objectDoc in snapshot.docs) {
        var object = ARNode.fromMap(objectDoc.data());
        arObjectManager!.addNode(object, planeAnchor: anchor);
        nodes.add(object);
      }
    });*/

    return anchor;
  }

  Future<void> onDownloadButtonPressed() async {
    if (arLocationManager!.currentLocation != null) {
      firebaseManager.downloadAnchorsByLocation((snapshot) {
        final cloudAnchorId = snapshot.get("cloudanchorid");
        // anchorsInDownloadProgress![cloudAnchorId] = snapshot.data();
        arAnchorManager!.downloadAnchor(cloudAnchorId);
      }, arLocationManager!.currentLocation, 0.1);
      readyToDownload = false;
    } else {
      arSessionManager!
          .onError("Location updates not running, can't donwload anchors");
    }
  }

  void showAlertDialog(String title, String content, String buttonText,
      Function buttonFunction, String cancelButtonText) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text(cancelButtonText),
      onPressed: () {
        GetNavigator(
          pages: [],
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
}
