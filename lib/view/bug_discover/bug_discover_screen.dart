import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prepare/core/controller/bug_dicover/all_cities_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';

import 'package:prepare/core/controller/bug_dicover/fly_note_controller.dart';
import 'package:prepare/core/controller/bug_dicover/fly_sample_controller.dart';
import 'package:prepare/core/controller/bug_dicover/fly_type_controller.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/image_picker_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/core/service/bug_discover_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/bug_discover/widgets/all_cities_widget.dart';
import 'package:prepare/view/bug_discover/widgets/all_district_widget.dart';
import 'package:prepare/view/bug_discover/widgets/fly_note_widget.dart';
import 'package:prepare/view/bug_discover/widgets/fly_sample_widget.dart';
import 'package:prepare/view/bug_discover/widgets/fly_type_id_widget.dart';
import 'package:prepare/view/bug_discover/widgets/humidity_widget.dart';
import 'package:prepare/view/bug_discover/widgets/ph_widget.dart';
import 'package:prepare/view/bug_discover/widgets/recommendation_widget.dart';
import 'package:prepare/view/bug_discover/widgets/street_widget.dart';
import 'package:prepare/view/bug_discover/widgets/temperature_widget.dart';
import 'package:prepare/view/bug_discover/widgets/waving_widget.dart';
import 'package:prepare/view/bug_discover/widgets/windspeed_widget.dart';
import 'package:prepare/view/home/home_screen.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class BugDiscoverScreen extends StatelessWidget {
  BugDiscoverScreen({
    Key? key,
  }) : super(key: key);

  final _reportFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? street;
  String? ph;
  String? recommendation;
  //===============
  double? windspeed;
  double? temperature;
  double? humidity;
  double? waving;
////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    //  AllCitiesController cityCtrl = Get.put(AllCitiesController());
    return Scaffold(
        body: GetBuilder<ImagePickerController>(
            init: ImagePickerController(),
            builder: (imgCtrl) {
              return HawkFabMenu(
                openIcon: Icons.add,
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
                      key: _reportFormKey,
                      child: Column(
                        children: [
                          const HeaderWidget(arrow: true),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          const AutoSizeText(
                            "الإستكشاف الحشري ",
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
                                //<<<<<<<<<<<<<<<<<<String Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== street ==========
                                StreetWidget(onChange: (value) {
                                  street = value;
                                }),
                                //====== ph ==========
                                PhWidget(onChange: (value) {
                                  ph = value;
                                }),
                                //====== Recommendation  ==========
                                RecommendationWidget(onChange: (value) {
                                  recommendation = value;
                                }),
                                //<<<<<<<<<<<<<<<<<<double Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== windspeed  ==========
                                WindspeedWidget(onSave: (value) {
                                  windspeed = double.parse(value ?? "");
                                }),
                                //====== temperature  ==========
                                TemperatureWidget(onSave: (value) {
                                  temperature = double.parse(value ?? "");
                                }),
                                //====== humidity  ==========
                                HumidityWidget(onSave: (value) {
                                  humidity = double.parse(value ?? "");
                                }),
                                //====== waving  ==========
                                WavingWidget(onSave: (value) {
                                  waving = double.parse(value ?? "");
                                }),
                                //<<<<<<<<<<<<<<<<<<Dropdown Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== Cities  & District==========

                                GetBuilder<AllCitiesController>(
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

                                //====== flyType ==========
                                const FlyTypeIdWidget(),
                                //====== flynoteId  ==========
                                const FlyNoteWidget(),
                                //====== flySampleTypeId  ==========
                                const FlySampleWidget(),
                                //<<<<<<<<<<<<<<<<<<Two Images >>>>>>>>>>>>>>>>>>>>>>>>>>>

                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    imgCtrl.image != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: lightPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.file(
                                              imgCtrl.image!,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/question-mark.png',
                                                  width: 45,
                                                  height: 45,
                                                ),
                                                const Text(
                                                  'برجاء إرفاق صورة البلاغ الاولى ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'hanimation',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                    imgCtrl.image2 != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: lightPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.file(
                                              imgCtrl.image2!,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/question-mark.png',
                                                  width: 45,
                                                  height: 45,
                                                ),
                                                const Text(
                                                  'برجاء إرفاق صورة البلاغ الثانية',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'hanimation',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Send Report button
                          GetBuilder<CurrentLocationController>(
                              init: CurrentLocationController(),
                              builder: (locationCtrl) {
                                return GetBuilder<AllFlyTypeController>(
                                    init: AllFlyTypeController(),
                                    builder: (flyType) {
                                      return GetBuilder<AllFlyNoteController>(
                                          init: AllFlyNoteController(),
                                          builder: (flyNoteCtrl) {
                                            return GetBuilder<
                                                    AllFlySampleController>(
                                                init: AllFlySampleController(),
                                                builder: (sampleCtrl) {
                                                  return GetBuilder<
                                                          AllCitiesController>(
                                                      init:
                                                          AllCitiesController(),
                                                      builder: (cityCtrl) {
                                                        return GetBuilder<
                                                                AllDistrictController>(
                                                            init:
                                                                AllDistrictController(
                                                                    cityCtrl
                                                                        .cityId
                                                                        .value),
                                                            builder: (disCtrl) {
                                                              return GetBuilder<
                                                                      InternetController>(
                                                                  init:
                                                                      InternetController(),
                                                                  builder:
                                                                      (net) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        if (_reportFormKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          _reportFormKey
                                                                              .currentState!
                                                                              .save();

                                                                          if (locationCtrl.currentLat == 0 &&
                                                                              locationCtrl.currentLong == 0) {
                                                                            toast("please open Gps ",
                                                                                duration: const Duration(seconds: 2));
                                                                          } else if (flyType.flyTypeText ==
                                                                              "إختر نوع الموقع") {
                                                                            toast("برجاء اختيار نوع الموقع",
                                                                                duration: const Duration(seconds: 2));
                                                                          } else if (flyNoteCtrl.flyNoteText ==
                                                                              "إختر نوع الملاحظة") {
                                                                            toast("برجاء اختيار نوع الملاحظة",
                                                                                duration: const Duration(seconds: 2));
                                                                          } else if (sampleCtrl.flySampleText ==
                                                                              "إختر نوع العينة ") {
                                                                            toast("برجاء اختيار نوع العينة",
                                                                                duration: const Duration(seconds: 2));
                                                                          } else if (cityCtrl.cityText ==
                                                                              "إختر إسم المدينة") {
                                                                            toast("برجاء اختيار إسم المدينة",
                                                                                duration: const Duration(seconds: 2));
                                                                          }
                                                                          //   else if(disCtrl.districtText=="إختر إسم الحي "){
                                                                          //      toast("برجاء اختيار إسم الحي",duration:const Duration(seconds: 2));
                                                                          //  }

                                                                          // else if (imgCtrl.image ==
                                                                          //     null) {
                                                                          //   toast("برجاء اختيار الصورة الاولي",
                                                                          //       duration: const Duration(seconds: 2));
                                                                          // } else if (imgCtrl.image2 ==
                                                                          //     null) {
                                                                          //   toast("برجاء اختيار الصورة الثانية",
                                                                          //       duration: const Duration(seconds: 2));
                                                                          // }
                                                                          else {
                                                                            net.checkInternet().then((val) {
                                                                              if (val) {
                                                                                BugDiscoverServices.sendFormData(districtId: 1, flyNoteId: flyNoteCtrl.flyNoteId, flySampleTypeId: sampleCtrl.flySampleId, flyTypeId: flyType.flyTypeId, humidity: humidity, imge: imgCtrl.image!, imge2: imgCtrl.image2!, lat: locationCtrl.currentLat, long: locationCtrl.currentLong, ph: ph, recommendation: recommendation, street: street, temperature: temperature, waving: waving, windSpeed: windspeed).then((value) {
                                                                                  if (value == 400) {
                                                                                    toast("يوجد خطأ فى الإرسال ", duration: const Duration(seconds: 2));
                                                                                  } else if (value == 401) {
                                                                                    Get.offAll(const LoginScreen());
                                                                                  } else if (value == 201) {
                                                                                    CoolAlert.show(
                                                                                      barrierDismissible: false,
                                                                                      context: context,
                                                                                      type: CoolAlertType.success,
                                                                                      title: "تم الارسال بنجاح",
                                                                                      confirmBtnText: "حسناً",
                                                                                      confirmBtnColor: primaryColor,
                                                                                      backgroundColor: primaryColor,
                                                                                      onConfirmBtnTap: () {
                                                                                        Get.offAll(() => const HomeScreen());
                                                                                      },
                                                                                    );
                                                                                  }
                                                                                });
                                                                              }
                                                                            });

                                                                            log(TokenPref.getTokenValue());
                                                                            log("street : $street");
                                                                            log("ph : $ph");
                                                                            log("recommendation : $recommendation");
                                                                            log("windspeed : $windspeed");
                                                                            log("temperature : $temperature");
                                                                            log("humidity : $humidity");
                                                                            log("waving : $waving");
                                                                            log("current Lat  : ${locationCtrl.currentLat}");
                                                                            log("current Long  : ${locationCtrl.currentLong}");
                                                                            log("flytype  : ${flyType.flyTypeText}");
                                                                            log("flyNote  : ${flyNoteCtrl.flyNoteText}");
                                                                            log("city   : ${cityCtrl.cityText}");
                                                                            log("District  : ${disCtrl.districtText}");
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                17,
                                                                        width:
                                                                            MediaQuery.of(context).size.width /
                                                                                2,
                                                                        decoration:
                                                                            BoxDecoration(
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
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          "إرسال الإستكشاف ",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 18),
                                                                          textAlign:
                                                                              TextAlign.center,
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
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}





/*


     GetBuilder<AllCitiesController>(
            init: AllCitiesController(),
            builder: (controller) {
            return Column(
            children: [
            Padding(
            padding: const EdgeInsets.symmetric(
            vertical: 10),
            child: GestureDetector(
            onTap: () {
            showModalBottomSheet(
            context: context,
            builder: (ctx) => controller
              .loading ==
            true
            ? const LoaderWidget()
            : SizedBox(
            height: MediaQuery.of(
                      context)
                  .size
                  .height /
              2.5,
            child: ListView
              .builder(
                  itemCount: controller
                      .cities
                      .length,
                  itemBuilder:
                      (context,
                          index) {
                    return InkWell(
                      onTap:
                          () {
                        controller.onTapSelected(
                            ctx,
                            controller.cities[index].id);
                      },
                      child:
                          Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15),
                        child:
                            Container(
                          alignment:
                              Alignment.center,
                          height:
                              MediaQuery.of(context).size.height / 12,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                          child:
                              Text(
                            controller.cities[index].name,
                            style: const TextStyle(color: primaryColor, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            );
            },
            child: Container(
            padding:
            const EdgeInsets.only(
            right: 7),
            margin: const EdgeInsets
            .symmetric(
            horizontal: 30),
            alignment:
            Alignment.centerRight,
            // width:
            //     MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context)
            .size
            .height /
            16,
            decoration: BoxDecoration(
            border: Border.all(
            width: 1,
            color: Colors.grey),
            borderRadius:
            BorderRadius.circular(
            5),
            ),
            child: Row(
            mainAxisAlignment:
            MainAxisAlignment
            .spaceAround,
            children: [
            Text(
            controller.cityText,
            textAlign:
            TextAlign.center,
            style: const TextStyle(
            height: 1.1,
            fontSize: 15,
            fontWeight:
              FontWeight.bold,
            color: blackColor),
            ),
            const Spacer(),
            const Icon(
            Icons.arrow_drop_down,
            color: blackColor,
            size: 30,
            ),
            ],
            ),
            )),
            ),
            //====== idstrictId ==========
            if (controller.cityId != 0)
            Padding(
            padding:
            const EdgeInsets.symmetric(
            vertical: 10),
            child: GetBuilder<
            AllDistrictController>(
            init: AllDistrictController(
            controller.cityId),
            builder: (districtCtrl) {
            return GestureDetector(
            onTap: () {
            showModalBottomSheet(
            context: context,
            builder: (ctx) =>
              districtCtrl.loading ==
                      true
                  ? const LoaderWidget()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height /
                          2.5,
                      child: ListView.builder(
                          itemCount: districtCtrl.district.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                districtCtrl.onTapSelected(ctx, districtCtrl.district[index].id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height / 12,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                  child: Text(
                                    districtCtrl.district[index].name,
                                    style: const TextStyle(color: primaryColor, fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            );
            },
            child: Container(
            padding:
            const EdgeInsets
                    .only(
                right: 7),
            margin:
            const EdgeInsets
                    .symmetric(
                horizontal:
                    30),
            alignment: Alignment
            .centerRight,
            // width:
            //     MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(
                    context)
                .size
                .height /
            16,
            decoration:
            BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors
                  .grey),
            borderRadius:
              BorderRadius
                  .circular(
                      5),
            ),
            child: Row(
            mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,
            children: [
            Text(
              districtCtrl
                  .districtText,
              textAlign:
                  TextAlign
                      .center,
              style: const TextStyle(
                  height: 1.1,
                  fontSize:
                      15,
                  fontWeight:
                      FontWeight
                          .bold,
                  color:
                      blackColor),
            ),
            const Spacer(),
            const Icon(
              Icons
                  .arrow_drop_down,
              color:
                  blackColor,
              size: 30,
            ),
            ],
            ),
            ));
            }),
            )
            ],
            );
            }),


 */