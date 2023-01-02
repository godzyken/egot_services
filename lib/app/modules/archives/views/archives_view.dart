import 'package:flutter/material.dart';

import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:get/get.dart';

import '../controllers/archives_controller.dart';
import 'model_selection_widget.dart';

class ArchivesView extends GetView<ArchivesController> {
  const ArchivesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchivesController>(
      init: ArchivesController(),
      builder: (_) {
        if (_.error.isTrue) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  const Text('Firebase initialization failed'),
                  ElevatedButton(
                      onPressed: () => _.initialize, child: const Text('Retry'))
                ],
              ),
            ),
          );
        }

        if (_.initialize.isFalse) {
          return Scaffold(
            body: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Firebase initialization failed'),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              ARView(
                showPlatformType: true,
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
                      visible: _.readyToUpload.value,
                    ),
                    Visibility(
                      child: ElevatedButton(
                        onPressed: _.onDownloadButtonPressed,
                        child: const Text("Download"),
                      ),
                      visible: _.readyToDownload.value,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.centerLeft,
                child: Visibility(
                  visible: _.modelChoiceActive.value,
                  child: ModelSelectionWidget(
                      onTap: _.onModelSelected,
                      firebaseManager: _.firebaseManager),
                ),
              ),
              _.anchorWasFound.value
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Point the camera at the pointer',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
