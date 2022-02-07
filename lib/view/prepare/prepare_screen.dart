import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/click_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/controller/prepareControllers/cars_controller.dart';
import 'package:prepare/core/controller/prepareControllers/devices_controllers.dart';
import 'package:prepare/core/controller/prepareControllers/pestsides_controllers.dart';
import 'package:prepare/core/controller/prepareControllers/team_controllers.dart';
import 'package:prepare/core/controller/prepareControllers/tools_controller.dart';
import 'package:prepare/core/service/prepration_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/home/home_screen.dart';
import 'package:prepare/view/prepare/widgets/cars_dialog_widget.dart';
import 'package:prepare/view/prepare/widgets/devices_dialog_widget.dart';
import 'package:prepare/view/prepare/widgets/pesticides_dialog_widget.dart';
import 'package:prepare/view/prepare/widgets/single_list_item_widget.dart';
import 'package:prepare/view/prepare/widgets/team_dialog_widget.dart';
import 'package:prepare/view/prepare/widgets/tools_dialog_widget.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class PrepareScreen extends StatelessWidget {
  PrepareScreen({Key? key, required this.id, required this.title})
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
                            //==================================
                            //============== cars ==============
                            //==================================
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return CarsDialogWidget(
                                              title: "إدخل عدد السيارات ",
                                              label: "عدد السيارات",
                                              emptyErrorText:
                                                  "برجاء إدخال عدد السيارات");
                                        });
                                  });
                                },
                                child: GetBuilder<CarsController>(
                                    init: CarsController(),
                                    builder: (controller) {
                                      carCount = controller
                                          .getCarsSum(controller.carsCount);
                                      return SingleListItem(
                                          title: "عدد السيارات",
                                          count:
                                              "${controller.getCarsSum(controller.carsCount)}");
                                    })),
                            //==================================
                            //============== tools ==============
                            //==================================
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return ToolsDialogWidget(
                                                title: "إدخل عدد الادوات",
                                                label: "عدد الادوات",
                                                emptyErrorText:
                                                    'برجاء إدخال عدد الادوات');
                                          });
                                    }
                                  });
                                },
                                child: GetBuilder<ToolsController>(
                                    init: ToolsController(),
                                    builder: (controller) {
                                      toolCount = controller
                                          .getToolsSum(controller.toolsCount);
                                      return SingleListItem(
                                          title: "عدد الأداوات",
                                          count:
                                              "${controller.getToolsSum(controller.toolsCount)}");
                                    })),
                            //==================================
                            //============== devices ==============
                            //==================================
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return DevicesDialogWidget(
                                                title: "إدخل عدد الاجهزة",
                                                label: "عدد الأجهزة",
                                                emptyErrorText:
                                                    'برجاء إدخال عدد الأجهزة');
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
                                          title: "عدد الأجهزة ",
                                          count:
                                              "${controller.getDeviceSum(controller.devicesCount)}");
                                    })),
                            //==================================
                            //============== pesticides ==============
                            //==================================
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return PesticidesDialogWidget(
                                                title:
                                                    'برجاء إدخال عدد المبيدات',
                                                label: "عدد المبيدات",
                                                emptyErrorText:
                                                    'برجاء إدخال عدد المبيدات');
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
                                          title: "عدد المبيدات",
                                          count:
                                              "${controller.getPestSideSum(controller.pestsidesCount)}");
                                    })),
                            //==================================
                            //============== Team ==============
                            //==================================
                            InkWell(
                                onTap: () {
                                  net.checkInternet().then((val) {
                                    if (val) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return TeamDialogWidget(
                                                title: "إدخل عدد العمال",
                                                label: "عدد العمال",
                                                emptyErrorText:
                                                    'برجاء إدخال عدد العمال');
                                          });
                                    }
                                  });
                                },
                                child: GetBuilder<TeamController>(
                                    init: TeamController(),
                                    builder: (controller) {
                                      teamCount =
                                          int.parse(controller.teamCount.value);
                                      return SingleListItem(
                                          title: "عدد العمال ",
                                          count: controller.teamCount.value);
                                    })),
                            //============== ************* ==============
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            //==================================
                            //============== submit ==============
                            //==================================
                            GetBuilder<InternetController>(
                                init: InternetController(),
                                builder: (net) {
                                  return GetBuilder<ClickController>(
                                      init: ClickController(),
                                      builder: (click) {
                                        return InkWell(
                                          onTap: () async {
                                            net
                                                .checkInternet()
                                                .then((netVal) async {
                                              if (netVal) {
                                                if (click.clicked == false) {
                                                  if (carCount == 0 ||
                                                      toolCount == 0 ||
                                                      deviceCount == 0 ||
                                                      pestsideCount == 0 ||
                                                      teamCount == 0) {
                                                    CoolAlert.show(
                                                      context: context,
                                                      confirmBtnTextStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                      cancelBtnTextStyle:
                                                          const TextStyle(
                                                              color: redColor,
                                                              fontSize: 22),
                                                      type: CoolAlertType.error,
                                                      title:
                                                          " لم يتم ادخال كل البيانات المطلوبة للتحضير ",
                                                      text: "هل انت متأكد ؟",
                                                      showCancelBtn: true,
                                                      onConfirmBtnTap:
                                                          () async {
                                                        var res = await PreprationServices
                                                            .addPrepration(
                                                                projectId: id,
                                                                numberOfEmployees:
                                                                    teamCount,
                                                                numberOfTools:
                                                                    toolCount,
                                                                numberOfVehicles:
                                                                    carCount,
                                                                numberOfDevices:
                                                                    deviceCount,
                                                                numberOfExterminators:
                                                                    pestsideCount);
                                                        if (res == 200) {
                                                          Get.offAll(
                                                              const HomeScreen());
                                                          CoolAlert.show(
                                                            context: context,
                                                            type: CoolAlertType
                                                                .confirm,
                                                            title:
                                                                "تم إضافة تحضير للمشروع بنجاح",
                                                            onConfirmBtnTap:
                                                                () {},
                                                            confirmBtnText:
                                                                "حسناً ",
                                                            confirmBtnColor:
                                                                lightPrimaryColor,
                                                            backgroundColor:
                                                                lightPrimaryColor,
                                                          );
                                                        } else if (res == 401) {
                                                          Get.offAll(
                                                              const LoginScreen());
                                                        }
                                                      },
                                                      onCancelBtnTap: () {
                                                        Get.back();
                                                        click.changeClick();
                                                      },
                                                      confirmBtnText: "نعم ",
                                                      cancelBtnText: "لا",
                                                      confirmBtnColor:
                                                          lightPrimaryColor,
                                                      backgroundColor: redColor,
                                                    );
                                                  } else {
                                                    var res = await PreprationServices
                                                        .addPrepration(
                                                            projectId: id,
                                                            numberOfEmployees:
                                                                teamCount,
                                                            numberOfTools:
                                                                toolCount,
                                                            numberOfVehicles:
                                                                carCount,
                                                            numberOfDevices:
                                                                deviceCount,
                                                            numberOfExterminators:
                                                                pestsideCount);
                                                    if (res == 200) {
                                                      Get.offAll(
                                                          const HomeScreen());
                                                      CoolAlert.show(
                                                        context: context,
                                                        type: CoolAlertType
                                                            .success,
                                                        title:
                                                            "تم إضافة تحضير للمشروع بنجاح",
                                                        onConfirmBtnTap: () {
                                                          Get.back();
                                                        },
                                                        confirmBtnText:
                                                            "حسناً ",
                                                        confirmBtnColor:
                                                            lightPrimaryColor,
                                                        backgroundColor:
                                                            lightPrimaryColor,
                                                      );
                                                    } else if (res == 401) {
                                                      Get.offAll(
                                                          const LoginScreen());
                                                    }
                                                  }
                                                  click.changeClick();
                                                }
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                16,
                                            decoration: BoxDecoration(
                                                color: click.clicked == false
                                                    ? lightPrimaryColor
                                                    : Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Text(
                                              "تحضير ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'hanimation',
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
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
