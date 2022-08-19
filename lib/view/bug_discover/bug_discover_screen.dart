
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';
import 'widgets/all_cities_widget.dart';

import '../../core/controller/bug_dicover/all_cities_controller.dart';
import '../../core/controller/bug_dicover/all_district_controller.dart';
import '../../core/controller/bug_dicover/bug_discover_code_controller.dart';
import '../../core/controller/bug_dicover/fly_note_controller.dart';
import '../../core/controller/bug_dicover/fly_sample_controller.dart';
import '../../core/controller/bug_dicover/fly_type_controller.dart';
import '../../core/controller/click_controller.dart';
import '../../core/controller/current_location_controller.dart';
import '../../core/controller/image_picker_controller.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../core/service/bug_discover_services.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/images_widget.dart';
import '../shared_widgets/line_dot.dart';
import 'widgets/all_district_widget.dart';
import 'widgets/fly_note_widget.dart';
import 'widgets/fly_sample_widget.dart';
import 'widgets/fly_type_id_widget.dart';
import 'widgets/humidity_widget.dart';
import 'widgets/ph_widget.dart';
import 'widgets/recommendation_widget.dart';
import 'widgets/street_widget.dart';
import 'widgets/temperature_widget.dart';
import 'widgets/waving_widget.dart';
import 'widgets/windspeed_widget.dart';

// ignore: must_be_immutable
class BugDiscoverScreen extends StatelessWidget {
  BugDiscoverScreen({
    Key? key,
  }) : super(key: key);

  final _bugFormKey = GlobalKey<FormState>();

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
                openIcon: Icons.add_photo_alternate,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
                items: [
                  HawkFabMenuItem(
                      label: 'add first picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromGallrey();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'pick first picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromCam();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'add second picture'.tr,
                      ontap: () {
                        imgCtrl.pickImageFromGallrey2();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'pick second picture'.tr,
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
                      key: _bugFormKey,
                      child: Column(
                        children: [
                          const HeaderWidget(arrow: true),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          AutoSizeText(
                            'Insect Exploration'.tr,
                            style: const TextStyle(
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
                                //!<<<<<<<<<<<<<<<<<<Dropdown Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //!====== Cities  & District==========

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

                                //!====== flyType ==========
                                const FlyTypeIdWidget(),
                                //!====== flynoteId  ==========
                                const FlyNoteWidget(),
                                //!====== flySampleTypeId  ==========
                                const FlySampleWidget(),
                                //!<<<<<<<<<<<<<<<<<<Two Images >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //!<<<<<<<<<<<<<<<<<<String Type >>>>>>>>>>>>>>>>>>>>>>>>>>>

                                //!====== street ==========
                                StreetWidget(onChange: (value) {
                                  street = value;
                                }),
                                //!====== ph ==========
                                PhWidget(onChange: (value) {
                                  ph = value;
                                }),

                                //!<<<<<<<<<<<<<<<<<<double Type >>>>>>>>>>>>>>>>>>>>>>>>>>>

                                //!====== windspeed  ==========
                                WindspeedWidget(onSave: (value) {
                                  windspeed = double.parse(value ?? "");
                                }),
                                //!====== temperature  ==========
                                TemperatureWidget(onSave: (value) {
                                  temperature = double.parse(value ?? "");
                                }),
                                //!====== humidity  ==========
                                HumidityWidget(onSave: (value) {
                                  humidity = double.parse(value ?? "");
                                }),

                                //!====== waving  ==========
                                WavingWidget(onSave: (value) {
                                  waving = double.parse(value ?? "");
                                }),
                                //!====== Recommendation  ==========
                                RecommendationWidget(onChange: (value) {
                                  recommendation = value;
                                }),
                                //!<<<<<<<<<<<<<<<<<< Image Widget >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                ImagesWidget(
                                    path1: imgCtrl.image.path,
                                    path2: imgCtrl.image2.path,
                                    file1: imgCtrl.image,
                                    file2: imgCtrl.image2),
                                //! ===== ===== Generate Epicenter Code ===== =======
                               GetBuilder<AllFlyTypeController>(
                                    init: AllFlyTypeController(),
                                    builder: (flytypeCtrl) {
                                      return GetBuilder<AllCitiesController>(
                                          init: AllCitiesController(),
                                          builder: (cityCtrl) {
                                            return GetBuilder<
                                                    BugDiscoverCodeController>(
                                                init:
                                                    BugDiscoverCodeController(),
                                                builder: (codeCtrl) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 100,
                                                            left: 100,
                                                            top: 30,
                                                            bottom: 30),
                                                     
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            15,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        // border: Border.all(width: 1, color: Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: flytypeCtrl
                                                                    .flyTypeId ==
                                                                0 ||
                                                            cityCtrl.cityId
                                                                    .value ==
                                                                0
                                                        ? const SelectableText(
                                                            "لا يوجد كود حالياً ",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        : SelectableText(
                                                            codeCtrl
                                                                .getBugDiscoverCodeCount(
                                                                    cityCtrl
                                                                        .cityId
                                                                        .value,
                                                                    flytypeCtrl
                                                                        .flyTypeId)
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                  );
                                                });
                                          });
                                    })
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
                                                                AllDistrictController(),
                                                            builder: (disCtrl) {
                                                              return GetBuilder<
                                                                      InternetController>(
                                                                  init:
                                                                      InternetController(),
                                                                  builder:
                                                                      (net) {
                                                                    return GetBuilder<
                                                                            ClickController>(
                                                                        init:
                                                                            ClickController(),
                                                                        builder:
                                                                            (clk) {
                                                                          return GetBuilder<BugDiscoverCodeController>(
                                                                              init: BugDiscoverCodeController(),
                                                                              builder: (code) {
                                                                                return InkWell(
                                                                                  onTap: () async {
                                                                                    if (_bugFormKey.currentState!.validate()) {
                                                                                      _bugFormKey.currentState!.save();
                                                                                      if (clk.clicked == false) {
                                                                                        if (locationCtrl.lat == 0 && locationCtrl.long == 0) {
                                                                                          toast("please open Gps ", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (street == "") {
                                                                                          toast("برجاء إدخال إسم الشارع", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (ph == "") {
                                                                                          toast("برجاء إدخال ph", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (recommendation == "") {
                                                                                          toast("برجاء إدخال ملاحظات", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (flyType.flyTypeText == "نوع الموقع") {
                                                                                          toast("برجاء اختيار نوع الموقع", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (flyNoteCtrl.flyNoteText == "نوع الملاحظة") {
                                                                                          toast("برجاء اختيار نوع الملاحظة", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (sampleCtrl.flySampleText == "نوع العينة") {
                                                                                          toast("برجاء اختيار نوع العينة", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (cityCtrl.cityText.value == "البلدية") {
                                                                                          toast("برجاء اختيار البلدية", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else if (code.bugDiscoverCode.value == "") {
                                                                                          toast("عذراً لا يوجد كود ", duration: const Duration(seconds: 2));
                                                                                          clk.changeClick();
                                                                                        } else {
                                                                                          net.checkInternet().then((val) {
                                                                                            if (val) {
                                                                                  
                                                                                              BugDiscoverServices.sendFormData(
                                                                                                      districtId: disCtrl.districtId, // district
                                                                                                      flyNoteId: flyNoteCtrl.flyNoteId, // type of recommendation
                                                                                                      flySampleTypeId: sampleCtrl.flySampleId, //type of sample
                                                                                                      flyTypeId: flyType.flyTypeId,
                                                                                                      humidity: humidity,
                                                                                                      imge: imgCtrl.image,
                                                                                                      imge2: imgCtrl.image2,
                                                                                                      lat: locationCtrl.lat,
                                                                                                      long: locationCtrl.long,
                                                                                                      ph: ph,
                                                                                                      recommendation: recommendation,
                                                                                                      street: street,
                                                                                                      temperature: temperature,
                                                                                                      waving: waving,
                                                                                                      windSpeed: windspeed,
                                                                                                      code: code.bugDiscoverCode)
                                                                                                  .then((value) {
                                                                                                if (value == 400) {
                                                                                                  toast("يوجد خطأ فى الإرسال ", duration: const Duration(seconds: 2));
                                                                                                  clk.changeClick();
                                                                                                } else if (value == 401) {
                                                                                                  Get.offAll(const LoginScreen());
                                                                                                } else if (value == 201) {
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
                                                                                          });
                                                                                        }
                                                                                        clk.changeClick();
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    height: MediaQuery.of(context).size.height / 17,
                                                                                    width: MediaQuery.of(context).size.width / 2,
                                                                                    decoration: clk.clicked == false
                                                                                        ? BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(40),
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
                                                                                            borderRadius: BorderRadius.circular(40),
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
                                                                                    child: clk.clicked == false
                                                                                        ? const Text(
                                                                                            "إرسال الإستكشاف ",
                                                                                            style: TextStyle(color: Colors.white, fontSize: 18),
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
