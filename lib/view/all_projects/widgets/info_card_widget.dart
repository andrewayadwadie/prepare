import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/add_prepration_model.dart';
import '../../home/home_screen.dart';
import '../controller/rally_point_controller.dart';
import '../services/prepare_service.dart';

import '../../../utils/style.dart';
import '../controller/preparation_new_controller.dart';
import '../model/prepare_model.dart';
import 'info_card_body_item.dart';
import 'info_card_header.dart';
import 'info_list_item_widget.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({Key? key, required this.data, required this.index})
      : super(key: key);
  final ProjectModel data;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16, right: 5, left: 5),
      height: MediaQuery.of(context).size.height / 1.3,
      decoration: BoxDecoration(
        color: offwhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: GetBuilder<RallyPointController>(
          init: RallyPointController(
              data.projectCity.projectCityTasks[index].lat,
              data.projectCity.projectCityTasks[index].long),
          builder: (pointCtrl) {
            return pointCtrl.isCorrectPoint == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //! Header of Card
                      InfoCardHeader(
                        title: data.name,
                      ),
                      Divider(
                        endIndent: 20,
                        indent: 20,
                        height: 1.1,
                        thickness: 2,
                        color: blackColor.withOpacity(0.2),
                      ),
                      if (data.projectCity.projectCityTasks.isNotEmpty)
                        GetBuilder<NewPreparationController>(
                            init: NewPreparationController(data
                                .projectCity
                                .projectCityTasks[0]
                                .projectTrackVehicleTypesTasks),
                            builder: (ctrl) {
                              return Expanded(
                                flex: 5,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        InfoCardBodyItem(
                                          title: 'Number Of Employees'.tr,
                                          number: "?",
                                          controller: ctrl.employeesController,
                                        ),
                                        InfoCardBodyItem(
                                          title:
                                              'Number Of Sector Supervisors'.tr,
                                          number: "?",
                                          controller: ctrl.supervisorController,
                                        ),
                                        InfoCardBodyItem(
                                          title:
                                              'Number Of Control Specialist'.tr,
                                          number: "?",
                                          controller: ctrl.specailistController,
                                        ),
                                        InfoCardBodyItem(
                                          title: 'Number Of Driver'.tr,
                                          number: "?",
                                          controller: ctrl.driversController,
                                        ),
                                        InfoCardBodyItem(
                                          title: 'Number Of ULV'.tr,
                                          number: "?",
                                          controller: ctrl.ulvDevicesController,
                                        ),
                                        InfoCardBodyItem(
                                          title: 'Number Of fog'.tr,
                                          number: "?",
                                          controller: ctrl.fogDevicesController,
                                        ),
                                        InfoCardBodyItem(
                                          title: 'Number Of pump'.tr,
                                          number: "?",
                                          controller:
                                              ctrl.pumpDevicesController,
                                        ),
                                        InfoCardBodyItem(
                                          title: 'Number Of liquid'.tr,
                                          number: "?",
                                          controller:
                                              ctrl.liquidDevicesController,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if (data.status == 0) {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2.5,
                                                      child: ListView.builder(
                                                        itemCount: data
                                                            .projectCity
                                                            .projectCityTasks[0]
                                                            .projectTrackVehicleTypesTasks
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return InfoListItemWidget(
                                                            title: data
                                                                .projectCity
                                                                .projectCityTasks[
                                                                    0]
                                                                .projectTrackVehicleTypesTasks[
                                                                    index]
                                                                .trackVehicleType
                                                                .name,
                                                            number:
                                                                "${data.projectCity.projectCityTasks[0].projectTrackVehicleTypesTasks[index].count}",
                                                            controller:
                                                                ctrl.vehiclesController[
                                                                    index],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                Get.snackbar(
                                                    'The project has been prepared'
                                                        .tr,
                                                    'The project cannot be prepare d again'
                                                        .tr);
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              decoration: BoxDecoration(
                                                color: data.status == 0
                                                    ? lightPrimaryColor
                                                    : darkGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black54,
                                                      blurRadius: 6.0,
                                                      offset: Offset(0.0, 0.75))
                                                ],
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          80),
                                              child: Text(
                                                'Vehicles'.tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              ctrl.addVehiclePost(data
                                                  .projectCity
                                                  .projectCityTasks[0]
                                                  .projectTrackVehicleTypesTasks);
                                              if (data.status == 0) {
                                                PrepareServices.addPrepartion(
                                                        preparationModel: Preparation(
                                                            projectId: data.id,
                                                            projectCityPreparation: CityPrepration(
                                                                numberOfDrivers: ctrl
                                                                    .driversController
                                                                    .text,
                                                                numberOfLiquidDevices: ctrl
                                                                    .liquidDevicesController
                                                                    .text,
                                                                numberOfULVDevices: ctrl
                                                                    .ulvDevicesController
                                                                    .text,
                                                                numberOfFogDevices: ctrl
                                                                    .fogDevicesController
                                                                    .text,
                                                                numberOfPumps: ctrl
                                                                    .pumpDevicesController
                                                                    .text,
                                                                cityId: data
                                                                    .projectCity
                                                                    .cityId,
                                                                projectTrackVehicleTypesPreparations: ctrl
                                                                    .vechilesPost,
                                                                numberOfSectorSupervisors: ctrl
                                                                    .supervisorController
                                                                    .text,
                                                                numberOfControlSpecialist:
                                                                    ctrl.specailistController
                                                                        .text,
                                                                numberOfEmployees:
                                                                    ctrl.employeesController
                                                                        .text)))
                                                    .then((res) {
                                                  if (res == 200) {
                                                     Get.snackbar(
                                                        'Project preparation has been successfully added'
                                                            .tr,
                                                        "");
                                                    Get.offAll(const HomeScreen());
                                                  } else if (res.runtimeType !=
                                                      int) {
                                                    Get.snackbar(
                                                        "There was an error while preparing"
                                                            .tr,
                                                        res);
                                                  } else if (res == 500) {
                                                    Get.snackbar(
                                                        "There was an error while preparing"
                                                            .tr,
                                                        "server error".tr);
                                                  } else {
                                                    Get.snackbar(
                                                        "There was an error while preparing"
                                                            .tr,
                                                        "");
                                                  }
                                                });
                                              } else {
                                                Get.snackbar(
                                                    'The project has been prepared'
                                                        .tr,
                                                    'The project cannot be prepare d again'
                                                        .tr);
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: data.status == 0
                                                    ? lightPrimaryColor
                                                    : darkGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black54,
                                                      blurRadius: 6.0,
                                                      offset: Offset(0.0, 0.75))
                                                ],
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          80),
                                              child: data.status == 0
                                                  ? Text(
                                                      'prepare'.tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  : Text(
                                                      'The project has been prepared'
                                                          .tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }),
                      if (data.projectCity.projectCityTasks.isEmpty)
                        Expanded(
                            flex: 5,
                            child:
                                Center(child: Text('No preparations today'.tr)))
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 16, right: 5, left: 5),
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      color: offwhiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                        "You are currently far from the assembly point ".tr));
          }),
    );
  }
}
