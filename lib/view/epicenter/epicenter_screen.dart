import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../core/controller/bug_dicover/all_cities_controller.dart';
import '../../core/controller/bug_dicover/all_district_controller.dart';
import '../../core/controller/click_controller.dart';
import '../../core/controller/current_location_controller.dart';
import '../../core/controller/epicenter/all_insects_controller.dart';
import '../../core/controller/epicenter/insect_code_controller.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../core/service/epicenter_services.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../bug_discover/widgets/all_cities_widget.dart';
import '../bug_discover/widgets/all_district_widget.dart';
import '../bug_discover/widgets/humidity_widget.dart';
import '../bug_discover/widgets/recommendation_widget.dart';
import '../bug_discover/widgets/temperature_widget.dart';
import '../bug_discover/widgets/windspeed_widget.dart';
import 'widgets/insect_widget.dart';
import 'widgets/name_widget.dart';
import 'widgets/number_widget.dart';
import '../home/home_screen.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class EpiCenterScreen extends StatelessWidget {
  EpiCenterScreen({Key? key}) : super(key: key);
  final _epiCenterFormKey = GlobalKey<FormState>();
  String? name;
  String? number;
  String? recommendation;
  String? windspeed;
  String? temperature;
  String? humidity;
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
              AutoSizeText(
                'Add density measurement'.tr,
                style: const TextStyle(
                    color: lightPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const LineDots(),
              Container(
                height: MediaQuery.of(context).size.height / 1.83,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                padding: const EdgeInsets.all(5),
                child: ListView(
                  children: [
                    //!======= insects =================
                    const InsectWidget(),
                    //!====== Cities  & District==========
                      GetBuilder<AllCitiesController>(
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

                    //!====== name ==========
                    NameWidget(onChange: (value) {
                      name = value;
                    }),

                    //!====== windspeed  ==========
                    WindspeedWidget(onSave: (value) {
                      windspeed = value ?? "";
                    }),
                    //!====== temperature  ==========
                    TemperatureWidget(onSave: (value) {
                      temperature = value ?? "";
                    }),
                    //!====== humidity  ==========
                    HumidityWidget(onSave: (value) {
                      humidity = value ?? "";
                    }),

                    //!====== Number ==========
                    NumberWidget(onChange: (value) {
                      number = value;
                    }),
                    //!====== Recommendation  ==========
                    RecommendationWidget(onChange: (value) {
                      recommendation = value;
                    }),

                    // !====== Generate Epicenter Code
                    GetBuilder<AllInsectsController>(
                        init: AllInsectsController(),
                        builder: (insect) {
                          return GetX<InsectCodeController>(
                              init: InsectCodeController(),
                              builder: (codeCtrl) {
                                return Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      right: 100,
                                      left: 100,
                                      top: 10,
                                      bottom: 30),
                                  //  width: MediaQuery.of(context).size.width/4,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: SelectableText(
                                    codeCtrl.insectCode.value,
                                    style: const TextStyle(fontSize: 15),
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
                    return GetBuilder<AllDistrictController>(
                        init: AllDistrictController(),
                        builder: (disCtrl) {
                          return GetBuilder<InternetController>(
                              init: InternetController(),
                              builder: (net) {
                                return GetBuilder<AllInsectsController>(
                                    init: AllInsectsController(),
                                    builder: (insectCtrl) {
                                      return GetBuilder<ClickController>(
                                          init: ClickController(),
                                          builder: (clk) {
                                            return GetBuilder<
                                                    InsectCodeController>(
                                                init: InsectCodeController(),
                                                builder: (insectCodeCtrl) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      if (_epiCenterFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        _epiCenterFormKey
                                                            .currentState!
                                                            .save();
                                                        if (clk.clicked ==
                                                            false) {
                                                          if (locationCtrl
                                                                      .lat ==
                                                                  0 &&
                                                              locationCtrl
                                                                      .long ==
                                                                  0) {
                                                            toast(
                                                                "please open Gps ",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (recommendation ==
                                                              "") {
                                                            toast(
                                                                'please enter notes'
                                                                    .tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (name ==
                                                              "") {
                                                            toast(
                                                                'Please enter the name'
                                                                    .tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (disCtrl
                                                                  .districtText
                                                                  .value ==
                                                              'District'.tr) {
                                                            toast(
                                                                'Please select the district'
                                                                    .tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (insectCtrl
                                                                  .insectsText ==
                                                              'Type of insect'
                                                                  .tr) {
                                                            toast(
                                                                'Please choose the insect type'
                                                                    .tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else {
                                                            net
                                                                .checkInternet()
                                                                .then((val) {
                                                              if (val) {
                                                                EpicenterServices.addEpiCenter(
                                                                        number: int.parse(number ??
                                                                            ""),
                                                                        code: insectCodeCtrl
                                                                            .insectCode
                                                                            .value,
                                                                        name: name ??
                                                                            "",
                                                                        lat:
                                                                            "${locationCtrl.lat}",
                                                                        long:
                                                                            "${locationCtrl.long}",
                                                                        insectId:
                                                                            insectCtrl
                                                                                .insectsId,
                                                                        districtId: disCtrl
                                                                            .districtId
                                                                            .value,
                                                                        humidity:
                                                                            humidity ??
                                                                                "",
                                                                        recommendation:
                                                                            recommendation ??
                                                                                "",
                                                                        temperature:
                                                                            temperature ??
                                                                                "",
                                                                        windSpeed:
                                                                            windspeed ??
                                                                                "")
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .runtimeType ==
                                                                      String) {
                                                                    toast(
                                                                        value
                                                                            .toString(),
                                                                        duration:
                                                                            const Duration(seconds: 2));
                                                                    clk.changeClick();
                                                                  } else if (value ==
                                                                      401) {
                                                                    Get.offAll(
                                                                        const LoginScreen());
                                                                  } else if (value ==
                                                                          201 ||
                                                                      value ==
                                                                          200) {
                                                                    Get.offAll(() =>
                                                                        const HomeScreen());
                                                                    CoolAlert
                                                                        .show(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      type: CoolAlertType
                                                                          .success,
                                                                      title:
                                                                          'Added successfully'
                                                                              .tr,
                                                                      confirmBtnText:
                                                                          'ok'.tr,
                                                                      confirmBtnTextStyle: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white),
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
                                                          clk.changeClick();
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      decoration:
                                                          clk.clicked == false
                                                              ? BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40),
                                                                  gradient:
                                                                      const LinearGradient(
                                                                          colors: [
                                                                            lightPrimaryColor,
                                                                            primaryColor,
                                                                          ],
                                                                          begin: FractionalOffset(
                                                                              0.0,
                                                                              0.0),
                                                                          end: FractionalOffset(
                                                                              1.0,
                                                                              0.0),
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          tileMode:
                                                                              TileMode.clamp),
                                                                )
                                                              : BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40),
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                            Colors.grey.shade300,
                                                                            Colors.grey,
                                                                          ],
                                                                          begin: const FractionalOffset(
                                                                              0.0,
                                                                              0.0),
                                                                          end: const FractionalOffset(
                                                                              1.0,
                                                                              0.0),
                                                                          stops: const [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                          tileMode:
                                                                              TileMode.clamp),
                                                                ),
                                                      child: clk.clicked ==
                                                              false
                                                          ? Text(
                                                              'Add a epicenter'
                                                                  .tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
      )),
    );
  }
}
