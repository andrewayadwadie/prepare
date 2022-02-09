import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prepare/core/controller/click_controller.dart';
import 'package:prepare/core/controller/epicenter/visit_epicenter_controller.dart';
import 'package:prepare/core/controller/image_picker_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/service/all_epicenter_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/bug_discover/widgets/humidity_widget.dart';
import 'package:prepare/view/bug_discover/widgets/ph_widget.dart';
import 'package:prepare/view/bug_discover/widgets/recommendation_widget.dart';
import 'package:prepare/view/bug_discover/widgets/temperature_widget.dart';
import 'package:prepare/view/bug_discover/widgets/waving_widget.dart';
import 'package:prepare/view/bug_discover/widgets/windspeed_widget.dart';
import 'package:prepare/view/home/home_screen.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';
import 'package:prepare/view/visit_bug_discover/widgets/all_insect_exploration_widget.dart';
import 'package:prepare/view/visit_bug_discover/widgets/site_status_widget.dart';

// ignore: must_be_immutable
class VisitBugDiscoverScreen extends StatelessWidget {
  VisitBugDiscoverScreen({Key? key}) : super(key: key);
  final _visitBugDiscoverFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? recommendation;
  String? ph;
  String? waving;
  String? windspeed;
  String? temperature;
  String? humidity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ImagePickerController>(
            init: ImagePickerController(),
            builder: (imgCtrl) {
              return HawkFabMenu(
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Form(
                            key: _visitBugDiscoverFormKey,
                            child: Column(
                              children: <Widget>[
                                const HeaderWidget(arrow: true),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                ),
                                const AutoSizeText(
                                  "زيارة إستكشاف حشري ",
                                  style: TextStyle(
                                      color: lightPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const LineDots(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.68,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  padding: const EdgeInsets.all(5),
                                  child: ListView(
                                    children: [
                                      //====== windspeed  ==========
                                      WindspeedWidget(onSave: (value) {
                                        windspeed = value;
                                      }),
                                      //====== temperature  ==========
                                      TemperatureWidget(onSave: (value) {
                                        temperature = value;
                                      }),
                                      //====== humidity  ==========
                                      HumidityWidget(onSave: (value) {
                                        humidity = value;
                                      }),
                                      //====== Recommendation  ==========
                                      RecommendationWidget(onChange: (value) {
                                        recommendation = value;
                                      }),
                                      //====== ph  ==========
                                      PhWidget(onChange: (value) {
                                        ph = value;
                                      }),
                                      //====== waving  ==========
                                      WavingWidget(onSave: (value) {
                                        waving = value;
                                      }),
                                      //======== all Insect Exploration =================
                                      const AllInsectExplorationWidget(),
                                      //====== Site Status  ==========
                                      SiteStatusWidget(),

                                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          imgCtrl.image.path != ""
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color:
                                                              lightPrimaryColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image.file(
                                                    imgCtrl.image,
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'hanimation',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          imgCtrl.image2.path != ""
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color:
                                                              lightPrimaryColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image.file(
                                                    imgCtrl.image2,
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'hanimation',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GetBuilder<InternetController>(
                                    init: InternetController(),
                                    builder: (net) {
                                      return GetBuilder<
                                              VisitEpicenterController>(
                                          init: VisitEpicenterController(),
                                          builder: (insectCtrl) {
                                            return GetBuilder<ClickController>(
                                                init: ClickController(),
                                                builder: (clk) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      if (_visitBugDiscoverFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        _visitBugDiscoverFormKey
                                                            .currentState!
                                                            .save();

                                                        if (clk.clicked ==
                                                            false) {
                                                          if (recommendation ==
                                                              "") {
                                                            toast(
                                                                "برجاء إدخال  ملاحظات",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (humidity ==
                                                              0.0.toString()) {
                                                            toast(
                                                                "برجاء إدخال  قيمة الرطوبة",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (windspeed ==
                                                              0.0.toString()) {
                                                            toast(
                                                                "برجاء إدخال  سرعة الرياح ",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (temperature ==
                                                              0.0.toString()) {
                                                            toast(
                                                                "برجاء إدخال  درجة الحرارة ",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (insectCtrl
                                                                  .epicenterText ==
                                                              "إختر البؤرة") {
                                                            toast(
                                                                "برجاء إختيار البؤرة ",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else {
                                                            net
                                                                .checkInternet()
                                                                .then((val) {
                                                              if (val) {}
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
                                                          ? const Text(
                                                              "إضافة زيارة إستكشاف ",
                                                              style: TextStyle(
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
                                    })
                              ],
                            )))),
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
                openIcon: Icons.add,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
              );
            }));
  }
}
