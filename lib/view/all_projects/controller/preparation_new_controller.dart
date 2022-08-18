import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/prepare_model.dart';

class NewPreparationController extends GetxController {
  final List<ProjectTrackVehicleTypesTasks> trackVehicles;
  NewPreparationController(this.trackVehicles);
  TextEditingController teamsController = TextEditingController();
  TextEditingController employeesController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController specailistController = TextEditingController();
  List<TextEditingController> vehiclesController = [];
  List<Map<String,dynamic>> vechilesPost = [];

  @override
  void onInit() {
    super.onInit();
    addVehicle(trackVehicles);
  }

  @override
  void onClose() {
    teamsController.dispose();
    employeesController.dispose();
    supervisorController.dispose();
    specailistController.dispose();
    super.onClose();
  }

  void addVehicle(List<ProjectTrackVehicleTypesTasks> trackVehicles) {
    for (int i = 0; i <= trackVehicles.length; i++) {
      vehiclesController.add(TextEditingController());
    }

    update();
  }

  void addVehiclePost(List<ProjectTrackVehicleTypesTasks> trackVehicles) {
    vechilesPost.clear();
    for (int i = 0; i < trackVehicles.length; i++) {

      vechilesPost.add(Map.from( {
        "Count": vehiclesController[i].text.toString(),
        "TrackVehicleTypeId": trackVehicles[i].trackVehicleTypeId.toString()
      }));
    }

    update();
  }
}
