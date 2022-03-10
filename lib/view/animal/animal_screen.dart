import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prepare/core/controller/animal_controller/animal_code_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_cities_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';
import 'package:prepare/core/controller/click_controller.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/image_picker_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/core/service/animal_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/home/home_screen.dart';
import 'package:prepare/view/shared_widgets/images_widget.dart';
import 'package:prepare/view/bug_discover/widgets/all_cities_widget.dart';
import 'package:prepare/view/bug_discover/widgets/all_district_widget.dart';
import 'package:prepare/view/bug_discover/widgets/street_widget.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class AnimalScreen extends StatelessWidget {
  AnimalScreen({Key? key}) : super(key: key);

  final _animalFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? street;

  @override
  Widget build(BuildContext context) {
    //  AllCitiesController cityCtrl = Get.put(AllCitiesController());
    return Scaffold(
        body: GetBuilder<ImagePickerController>(
            init: ImagePickerController(),
            builder: (imgCtrl) {
              return HawkFabMenu(
                openIcon: Icons.add_photo_alternate,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
                items: [
                  HawkFabMenuItem(
                      label: 'إضافة الصورة الأولى',
                      ontap: () {
                        imgCtrl.pickImageFromGallrey();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إلتقط الصورة الأولى ',
                      ontap: () {
                        imgCtrl.pickImageFromCam();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إضافة الصورة الثانية',
                      ontap: () {
                        imgCtrl.pickImageFromGallrey2();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إلتقط الصورة الثانية',
                      ontap: () {
                        imgCtrl.pickImageFromCam2();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                ],
                body: SafeArea(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: _animalFormKey,
                      child: Column(
                        children: [
                          const HeaderWidget(arrow: true),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          const AutoSizeText(
                            "إضافة كلاب ضالة ",
                            style: TextStyle(
                                color: lightPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const LineDots(),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.68,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            padding: const EdgeInsets.all(5),
                            child: ListView(
                              children: [
                                //<<<<<<<<<<<<<<<<<<Dropdown Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== Cities  & District==========

                                GetX<AllCitiesController>(
                                    init: AllCitiesController(),
                                    builder: (controller) {
                                      return Column(
                                        children: [
                                          AllCitiesWidget(
                                              controller: controller),
                                          if (controller.cityId.value != 0)
                                            AllDistrictWidget(
                                                id: controller.cityId.value)
                                        ],
                                      );
                                    }),
                                //<<<<<<<<<<<<<<<<<<String Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== street ==========
                                StreetWidget(onChange: (value) {
                                  street = value;
                                }),

                                //<<<<<<<<<<<<<<<<<<Two Images >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                ImagesWidget(
                                    path1: imgCtrl.image.path,
                                    path2: imgCtrl.image2.path,
                                    file1: imgCtrl.image,
                                    file2: imgCtrl.image2),
                                GetBuilder<AllCitiesController>(
                                    init: AllCitiesController(),
                                    builder: (cityCtrl) {
                                      return GetBuilder<AnimaCodeController>(
                                          init: AnimaCodeController(),
                                          builder: (codeCtrl) {
                                            return Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                  right: 100,
                                                  left: 100,
                                                  top: 30,
                                                  bottom: 30),
                                              //  width: MediaQuery.of(context).size.width/4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // border: Border.all(width: 1, color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ]),
                                              child: cityCtrl.cityId.value == 0
                                                  ? const SelectableText(
                                                      "لا يوجد كود حالياً ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : SelectableText(
                                                      codeCtrl
                                                          .getAnimalCode(
                                                              cityCtrl
                                                                  .cityId.value)
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                            );
                                          });
                                    })
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
                                            return GetBuilder<
                                                    InternetController>(
                                                init: InternetController(),
                                                builder: (net) {
                                                  return GetBuilder<
                                                          ClickController>(
                                                      init: ClickController(),
                                                      builder: (clk) {
                                                        return GetBuilder<
                                                                AnimaCodeController>(
                                                            init:
                                                                AnimaCodeController(),
                                                            builder: (code) {
                                                              return InkWell(
                                                                onTap:
                                                                    () async {
                                                                  if (_animalFormKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    _animalFormKey
                                                                        .currentState!
                                                                        .save();
                                                                    if (clk.clicked ==
                                                                        false) {
                                                                      if (locationCtrl.currentLat ==
                                                                              0 &&
                                                                          locationCtrl.currentLong ==
                                                                              0) {
                                                                        toast(
                                                                            "please open Gps ",
                                                                            duration:
                                                                                const Duration(seconds: 2));
                                                                        clk.changeClick();
                                                                      } else if (street ==
                                                                          "") {
                                                                        toast(
                                                                            "برجاء إدخال إسم الشارع",
                                                                            duration:
                                                                                const Duration(seconds: 2));
                                                                        clk.changeClick();
                                                                      } else if (cityCtrl
                                                                              .cityText
                                                                              .value ==
                                                                          "البلدية") {
                                                                        toast(
                                                                            "برجاء اختيار البلدية",
                                                                            duration:
                                                                                const Duration(seconds: 2));
                                                                        clk.changeClick();
                                                                      } else if (disCtrl
                                                                              .districtText
                                                                              .value ==
                                                                          "الحي") {
                                                                        toast(
                                                                            "برجاء اختيار الحي",
                                                                            duration:
                                                                                const Duration(seconds: 2));
                                                                        clk.changeClick();
                                                                      } else if (code
                                                                              .animalCode
                                                                              .value ==
                                                                          "") {
                                                                        toast(
                                                                            "عذراً لا يوجد كود",
                                                                            duration:
                                                                                const Duration(seconds: 2));
                                                                        clk.changeClick();
                                                                      } else {
                                                                        net.checkInternet().then(
                                                                            (val) {
                                                                          if (val) {
                                                                            if (clk.clicked ==
                                                                                false) {
                                                                              // code here
                                                                              AnimalServices.sendAnimalFormData(
                                                                                      street: street, // الشارع
                                                                                      districtId: disCtrl.districtId, // الحي
                                                                                      imge: imgCtrl.image, // صورة 1
                                                                                      imge2: imgCtrl.image2, // صورة 2
                                                                                      lat: locationCtrl.currentLat, // الطول
                                                                                      long: locationCtrl.currentLong, // العرض
                                                                                      code: code.animalCode.value)
                                                                                  .then((value) {
                                                                                log("token : ${TokenPref.getTokenValue()}");
                                                                                if (value == 400) {
                                                                                  toast("يوجد خطأ فى الإرسال ", duration: const Duration(seconds: 2));
                                                                                  clk.changeClick();
                                                                                } else if (value == 401) {
                                                                                  Get.offAll(const LoginScreen());
                                                                                } else if (value == 200) {
                                                                                  Get.offAll(() => const HomeScreen());
                                                                                  CoolAlert.show(
                                                                                    barrierDismissible: false,
                                                                                    context: context,
                                                                                    type: CoolAlertType.success,
                                                                                    title: "تم الارسال بنجاح",
                                                                                    confirmBtnText: "حسناً",
                                                                                    confirmBtnColor: primaryColor,
                                                                                    backgroundColor: primaryColor,
                                                                                    onConfirmBtnTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                  );
                                                                                }
                                                                              });
                                                                            }
                                                                            clk.changeClick();
                                                                          }
                                                                        });
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      17,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2,
                                                                  decoration: clk
                                                                              .clicked ==
                                                                          false
                                                                      ? BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          gradient: const LinearGradient(
                                                                              colors: [
                                                                                lightPrimaryColor,
                                                                                primaryColor,
                                                                              ],
                                                                              begin: FractionalOffset(0.0, 0.0),
                                                                              end: FractionalOffset(1.0, 0.0),
                                                                              stops: [0.0, 1.0],
                                                                              tileMode: TileMode.clamp),
                                                                        )
                                                                      : BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          gradient: LinearGradient(
                                                                              colors: [
                                                                                Colors.grey.shade300,
                                                                                Colors.grey,
                                                                              ],
                                                                              begin: const FractionalOffset(0.0, 0.0),
                                                                              end: const FractionalOffset(1.0, 0.0),
                                                                              stops: const [0.0, 1.0],
                                                                              tileMode: TileMode.clamp),
                                                                        ),
                                                                  child: clk.clicked ==
                                                                          false
                                                                      ? const Text(
                                                                          "إضافة كلاب ضالة ",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 18),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )
                                                                      : const CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                ),
                                                              );
                                                            });
                                                      });
                                                });
                                          });
                                    });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
