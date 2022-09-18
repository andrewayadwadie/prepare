import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/prepare_model.dart';

class NewPreparationController extends GetxController {
  final List<ProjectTrackVehicleTypesTasks> trackVehicles;
  NewPreparationController(this.trackVehicles);
 
  TextEditingController employeesController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController specailistController = TextEditingController();
  TextEditingController driversController = TextEditingController();
  TextEditingController ulvDevicesController = TextEditingController();
  TextEditingController fogDevicesController = TextEditingController();
  TextEditingController pumpDevicesController = TextEditingController();
  TextEditingController liquidDevicesController = TextEditingController();
  List<TextEditingController> vehiclesController = [];
  List vechilesPost = [];

  @override
  void onInit() {
    super.onInit();
    addVehicle(trackVehicles);
  }

  @override
  void onClose() {
 
    employeesController.dispose();
    supervisorController.dispose();
    specailistController.dispose();
    driversController.dispose();
    ulvDevicesController.dispose();
    fogDevicesController.dispose();
    pumpDevicesController.dispose();
    liquidDevicesController.dispose();
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
      vechilesPost.add({
          "Count": vehiclesController[i].text.toString(),
          "trackVehicleTypeId": "${trackVehicles[i].trackVehicleTypeId}"
          
          });
    }

    update();
  }
}
