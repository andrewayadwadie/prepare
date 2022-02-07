import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prepare/core/controller/bug_dicover/all_cities_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/epicenter/all_insects_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/service/epicenter_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/bug_discover/widgets/all_cities_widget.dart';
import 'package:prepare/view/bug_discover/widgets/all_district_widget.dart';
import 'package:prepare/view/epicenter/widgets/insect_widget.dart';
import 'package:prepare/view/epicenter/widgets/name_widget.dart';
import 'package:prepare/view/home/home_screen.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class EpiCenterScreen extends StatelessWidget {
  EpiCenterScreen({Key? key}) : super(key: key);

  final _epiCenterFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _epiCenterFormKey,
          child: Column(
            children: <Widget>[
              const HeaderWidget(arrow: true),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const AutoSizeText(
                "إضافة بؤرة",
                style: TextStyle(
                    color: lightPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const LineDots(),
              Container(
                height: MediaQuery.of(context).size.height / 1.68,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                padding: const EdgeInsets.all(5),
                child: ListView(
                  children: [
                    //====== name ==========
                    NameWidget(onChange: (value) {
                      name = value;
                    }),
                    // ======= insects =================

                    const InsectWidget(),

                    //====== Cities  & District==========

                    GetX<AllCitiesController>(
                        init: AllCitiesController(),
                        builder: (controller) {
                          return Column(
                            children: [
                              AllCitiesWidget(controller: controller),
                              if (controller.cityId.value != 0)
                                AllDistrictWidget(id: controller.cityId.value)
                            ],
                          );
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                  ],
                ),
              ),
              // Send Report button
              GetBuilder<CurrentLocationController>(
                  init: CurrentLocationController(),
                  builder: (locationCtrl) {
                    return GetBuilder<AllCitiesController>(
                        init: AllCitiesController(),
                        builder: (cityCtrl) {
                          return GetBuilder<AllDistrictController>(
                              init: AllDistrictController(),
                              builder: (disCtrl) {
                                return GetBuilder<InternetController>(
                                    init: InternetController(),
                                    builder: (net) {
                                      return GetBuilder<AllInsectsController>(
                                          init: AllInsectsController(),
                                          builder: (insectCtrl) {
                                            return InkWell(
                                              onTap: () async {
                                                log("hiiii");

                                                if (locationCtrl.currentLat ==
                                                        0 &&
                                                    locationCtrl.currentLong ==
                                                        0) {
                                                  toast("please open Gps ",
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else if (name == "") {
                                                  toast("برجاء إدخال  الاسم",
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else if (cityCtrl
                                                        .cityText.value ==
                                                    "إختر إسم المدينة") {
                                                  toast(
                                                      "برجاء اختيار إسم المدينة",
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else if (disCtrl
                                                        .districtText.value ==
                                                    "إختر إسم الحي ") {
                                                  toast("برجاء اختيار إسم الحي",
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else if (insectCtrl
                                                        .insectsText ==
                                                    "إختر نوع الحشرة") {
                                                  toast(
                                                      "برجاء اختيار  نوع الحشرة ",
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else {
                                                  net
                                                      .checkInternet()
                                                      .then((val) {
                                                    if (val) {
                                                      EpicenterServices.addEpiCenter(
                                                              name: name ?? "",
                                                              lat: locationCtrl
                                                                  .currentLat
                                                                  .toString(),
                                                              long: locationCtrl
                                                                  .currentLong
                                                                  .toString(),
                                                              insectId:
                                                                  insectCtrl
                                                                      .insectsId,
                                                              districtId: disCtrl
                                                                  .districtId
                                                                  .value)
                                                          .then((value) {
                                                        if (value == 400) {
                                                          toast(value,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                        } else if (value ==
                                                            401) {
                                                          Get.offAll(
                                                              const LoginScreen());
                                                        } else if (value ==
                                                                201 ||
                                                            value == 200) {
                                                          Get.offAll(() =>
                                                              const HomeScreen());
                                                          CoolAlert.show(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            type: CoolAlertType
                                                                .success,
                                                            title:
                                                                "تم الإضافة بنجاح",
                                                            confirmBtnText:
                                                                "حسناً",
                                                            confirmBtnColor:
                                                                primaryColor,
                                                            backgroundColor:
                                                                primaryColor,
                                                            onConfirmBtnTap:
                                                                () {
                                                              Get.back();
                                                            },
                                                          );
                                                        }
                                                      });
                                                    }
                                                  });
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    17,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                            lightPrimaryColor,
                                                            primaryColor,
                                                          ],
                                                          begin:
                                                              FractionalOffset(
                                                                  0.0, 0.0),
                                                          end: FractionalOffset(
                                                              1.0, 0.0),
                                                          stops: [0.0, 1.0],
                                                          tileMode:
                                                              TileMode.clamp),
                                                ),
                                                child: const Text(
                                                  "إضافة بؤرة ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          });
                                    });
                              });
                        });
                  })
            ],
          ),
        ),
      )),
    );
  }
}
