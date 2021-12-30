import 'package:flutter/material.dart';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:get/get.dart';

import '../controllers/archives_controller.dart';
import 'model_selection_widget.dart';

class ArchivesView extends GetView<ArchivesController> {
  const ArchivesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchivesController>(
      assignId: true,
      builder: (_) {
        return Scaffold(
          body: Stack(
            children: [
              ARView(
                showPlatformType: _.modelChoiceActive,
                onARViewCreated: _.onARViewCreated,
                permissionPromptDescription:
                    "Camera permission must be given to the app for AR functions to work",
                permissionPromptParentalRestriction:
                    "Camera permission is restriced by the OS, please check parental control settings",
                planeDetectionConfig:
                    PlaneDetectionConfig.horizontalAndVertical,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: _.onRemoveEverythinh,
                        child: const Text("Remove Everything")),
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      child: ElevatedButton(
                        onPressed: _.onUploadButtonPressed,
                        child: const Text("Upload"),
                      ),
                      visible: _.readyToUpload,
                    ),
                    Visibility(
                      child: ElevatedButton(
                        onPressed: _.onDownloadButtonPressed,
                        child: const Text("Download"),
                      ),
                      visible: _.readyToDownload,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.centerLeft,
                child: Visibility(
                  visible: _.modelChoiceActive,
                  child: ModelSelectionWidget(
                      onTap: _.onModelSelected,
                      firebaseManager: _.firebaseManager),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
