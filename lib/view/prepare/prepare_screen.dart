import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controller/click_controller.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../core/controller/prepareControllers/cars_controller.dart';
import '../../core/controller/prepareControllers/devices_controllers.dart';
import '../../core/controller/prepareControllers/pestsides_controllers.dart';
import '../../core/controller/prepareControllers/team_controllers.dart';
import '../../core/controller/prepareControllers/tools_controller.dart';
import '../../core/service/prepration_services.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class PrepareScreen extends StatelessWidget {
  PrepareScreen(
      {Key? key, required this.id, required this.title,  })
      : super(key: key);

  final int id;
  final String title;

  

  int carCount = 0;
  int deviceCount = 0;
  int toolCount = 0;
  int pestsideCount = 0;
  int teamCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.031,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderWidget(arrow: true),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontFamily: 'hanimation'),
                ),
                const LineDots(),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height / 1.47,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: GetBuilder<InternetController>(
                      init: InternetController(),
                      builder: (net) {
                        return ListView(
                          children: [
                            //!============== cars ==============
/*
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return CarsDialogWidget(
                                              vehicalList: vehicles,
                                              title: 'enter vehicles count'.tr,
                                              label: 'vehicles count'.tr,
                                              emptyErrorText:
                                                  'please enter vehicles count'
                                                      .tr);
                                        });
                                  });
                                },
                                child: GetBuilder<CarsController>(
                                    init: CarsController(),
                                    builder: (controller) {
                                      carCount = controller
                                          .getCarsSum(controller.carsCount);
                                      return SingleListItem(
                                          title: 'vehicles count'.tr,
                                          count:
                                              "${controller.getCarsSum(controller.carsCount)}");
                                    })),
*/
                            //!============== devices ==============
/*
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return DevicesDialogWidget(
                                                devices: devices,
                                                title: 'enter devices count'.tr,
                                                label: 'devices count'.tr,
                                                emptyErrorText:
                                                    'please enter devices count'
                                                        .tr);
                                          });
                                    }
                                  });
                                },
                                child: GetBuilder<DevicesController>(
                                    init: DevicesController(),
                                    builder: (controller) {
                                      deviceCount = controller.getDeviceSum(
                                          controller.devicesCount);
                                      return SingleListItem(
                                          title: 'devices count'.tr,
                                          count:
                                              "${controller.getDeviceSum(controller.devicesCount)}");
                                    })),
*/
                            //!============== pesticides ==============
/*
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return PesticidesDialogWidget(
                                                exterminators: exterminators,
                                                title:
                                                    'enter pesticide quantity'
                                                        .tr,
                                                label: 'pesticide quantity'.tr,
                                                emptyErrorText:
                                                    'enter pesticide quantity'
                                                        .tr);
                                          });
                                    }
                                  });
                                },
                                child: GetBuilder<PestsidesController>(
                                    init: PestsidesController(),
                                    builder: (controller) {
                                      pestsideCount = controller.getPestSideSum(
                                          controller.pestsidesCount);
                                      return SingleListItem(
                                          title: 'pesticide quantity'.tr,
                                          count:
                                              "${controller.getPestSideSum(controller.pestsidesCount)}");
                                    })),
*/
                            //!============== Team ==============
/*
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return TeamDialogWidget(
                                                teams: teams,
                                                title: 'enter team count'.tr,
                                                label: 'team count'.tr,
                                                emptyErrorText:
                                                    'please enter team count'
                                                        .tr);
                                          });
                                    }
                                  });
                                },
                                child: GetBuilder<TeamController>(
                                    init: TeamController(),
                                    builder: (controller) {
                                      teamCount = controller
                                          .getTeameSum(controller.teamCount);

                                      return SingleListItem(
                                          title: 'team count'.tr,
                                          count:
                                              "${controller.getTeameSum(controller.teamCount)}");
                                    })),
                                    */
                            //============== ************* ==============
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),

                            //!============== submit ==============

                            GetBuilder<InternetController>(
                                init: InternetController(),
                                builder: (net) {
                                  return GetBuilder<ClickController>(
                                      init: ClickController(),
                                      builder: (click) {
                                        return GetBuilder<CarsController>(
                                            init: CarsController(),
                                            builder: (carsCtrl) {
                                              return GetBuilder<
                                                      ToolsController>(
                                                  init: ToolsController(),
                                                  builder: (toolsCtrl) {
                                                    return GetBuilder<
                                                            DevicesController>(
                                                        init:
                                                            DevicesController(),
                                                        builder: (devicesCtrl) {
                                                          return GetBuilder<
                                                                  PestsidesController>(
                                                              init:
                                                                  PestsidesController(),
                                                              builder:
                                                                  (pestsidesCtrl) {
                                                                return GetBuilder<
                                                                        TeamController>(
                                                                    init:
                                                                        TeamController(),
                                                                    builder:
                                                                        (teamsCtrl) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          net.checkInternet().then(
                                                                              (netVal) async {
                                                                            if (netVal) {
                                                                              if (click.clicked == false) {
                                                                                if (carCount == 0 || toolCount == 0 || deviceCount == 0 || pestsideCount == 0 || teamCount == 0) {
                                                                                  CoolAlert.show(
                                                                                    context: context,
                                                                                    confirmBtnTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                    cancelBtnTextStyle: const TextStyle(color: redColor, fontSize: 22),
                                                                                    type: CoolAlertType.error,
                                                                                    title: 'Not all information required for preparation has been entered'.tr,
                                                                                    text: 'are you sure ?'.tr,
                                                                                    showCancelBtn: true,
                                                                                    onConfirmBtnTap: () async {
                                                                                      var res = await PreprationServices.addPrepration(projectId: id, carObjectList: carsCtrl.carObjectList, toolsObjectList: toolsCtrl.toolsObjectList, devicesObjectList: devicesCtrl.devicesObjectList, pestsideObjectList: pestsidesCtrl.pestSideObjectList, teamsObjectList: teamsCtrl.teamObjectList);
                                                                                      if (res == 200) {
                                                                                        Get.offAll(const HomeScreen());
                                                                                        CoolAlert.show(
                                                                                          context: context,
                                                                                          type: CoolAlertType.confirm,
                                                                                          confirmBtnTextStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.normal),
                                                                                          title: 'Project preparation has been successfully added'.tr,
                                                                                          onConfirmBtnTap: () {},
                                                                                          confirmBtnText: "ok".tr,
                                                                                          confirmBtnColor: lightPrimaryColor,
                                                                                          backgroundColor: lightPrimaryColor,
                                                                                        );
                                                                                      } else if (res == 401) {
                                                                                        Get.offAll(const LoginScreen());
                                                                                      }
                                                                                    },
                                                                                    onCancelBtnTap: () {
                                                                                      Get.back();
                                                                                      click.changeClick();
                                                                                    },
                                                                                    confirmBtnText: 'yes'.tr,
                                                                                    cancelBtnText: 'no'.tr,
                                                                                    confirmBtnColor: lightPrimaryColor,
                                                                                    backgroundColor: redColor,
                                                                                  );
                                                                                } else {
                                                                                  var res = await PreprationServices.addPrepration(projectId: id, carObjectList: carsCtrl.carObjectList, toolsObjectList: toolsCtrl.toolsObjectList, devicesObjectList: devicesCtrl.devicesObjectList, pestsideObjectList: pestsidesCtrl.pestSideObjectList, teamsObjectList: teamsCtrl.teamObjectList);
                                                                                  if (res == 200) {
                                                                                    Get.offAll(const HomeScreen());
                                                                                    CoolAlert.show(
                                                                                      context: context,
                                                                                      type: CoolAlertType.success,
                                                                                      title: 'Project preparation has been successfully added'.tr,
                                                                                      onConfirmBtnTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      confirmBtnTextStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.normal),
                                                                                      confirmBtnText: "ok".tr,
                                                                                      confirmBtnColor: lightPrimaryColor,
                                                                                      backgroundColor: lightPrimaryColor,
                                                                                    );
                                                                                  } else if (res == 401) {
                                                                                    Get.offAll(const LoginScreen());
                                                                                  }
                                                                                }
                                                                                click.changeClick();
                                                                              }
                                                                            }
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 16,
                                                                          decoration: BoxDecoration(
                                                                              color: click.clicked == false ? lightPrimaryColor : Colors.grey,
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child: click.clicked == false
                                                                              ? Text(
                                                                                  'prepare'.tr,
                                                                                  style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'hanimation', fontWeight: FontWeight.w600),
                                                                                  textAlign: TextAlign.center,
                                                                                )
                                                                              : const CircularProgressIndicator(
                                                                                  color: Colors.white,
                                                                                ),
                                                                        ),
                                                                      );
                                                                    });
                                                              });
                                                        });
                                                  });
                                            });
                                      });
                                })
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
