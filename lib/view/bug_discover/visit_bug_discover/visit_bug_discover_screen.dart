import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/controller/click_controller.dart';
import '../../../core/controller/image_picker_controller.dart';
import '../../../core/controller/internet_connectivity_controller.dart';
import '../../../core/controller/site_status_controller.dart';
import '../../../core/service/bug_discover_services.dart';
import '../../../utils/style.dart';
import '../../auth/login_screen.dart';
import '../../home/home_screen.dart';
import '../../shared_widgets/header_widget.dart';
import '../../shared_widgets/images_widget.dart';
import '../../shared_widgets/line_dot.dart';
import '../widgets/humidity_widget.dart';
import '../widgets/ph_widget.dart';
import '../widgets/recommendation_widget.dart';
import '../widgets/temperature_widget.dart';
import '../widgets/waving_widget.dart';
import '../widgets/windspeed_widget.dart';
import 'widgets/site_status_widget.dart';

// ignore: must_be_immutable
class VisitBugDiscoverScreen extends StatelessWidget {
  VisitBugDiscoverScreen({Key? key, required this.id}) : super(key: key);
  final _visitBugDiscoverFormKey = GlobalKey<FormState>();
  final int id;

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
                                 AutoSizeText(
                                  'visit Insect Exploration'.tr,
                                  style:const TextStyle(
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

                                      //====== ph  ==========
                                      PhWidget(onChange: (value) {
                                        ph = value;
                                      }),
                                      //====== waving  ==========
                                      WavingWidget(onSave: (value) {
                                        waving = value;
                                      }),
                                      //======== all Insect Exploration =================
                                      //====== Recommendation  ==========
                                      RecommendationWidget(onChange: (value) {
                                        recommendation = value;
                                      }),
                                      //====== Site Status  ==========
                                      SiteStatusWidget(),

                                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      ImagesWidget(
                                          path1: imgCtrl.image.path,
                                          path2: imgCtrl.image2.path,
                                          file1: imgCtrl.image,
                                          file2: imgCtrl.image2),
                                    ],
                                  ),
                                ),
                                GetBuilder<InternetController>(
                                    init: InternetController(),
                                    builder: (net) {
                                      return GetBuilder<ClickController>(
                                          init: ClickController(),
                                          builder: (clk) {
                                            return GetBuilder<
                                                    SiteStatusController>(
                                                init: SiteStatusController(),
                                                builder: (siteStatusCtrl) {
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
                                                                'please enter notes'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (humidity ==
                                                              "") {
                                                            toast(
                                                                'please enter humidity'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (windspeed ==
                                                              "") {
                                                            toast(
                                                                'please enter wind speed'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (temperature ==
                                                              "") {
                                                            toast(
                                                                'please enter the temperature'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (ph == "") {
                                                            toast(
                                                                'please enter ph'.tr,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                            clk.changeClick();
                                                          } else if (waving ==
                                                              "") {
                                                            toast(
                                                               'please enter salinity'.tr,
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
                                                                if (clk.clicked ==
                                                                    false) {
                                                                  BugDiscoverServices.sendVisitFormData(
                                                                          temperature:
                                                                              temperature,
                                                                          windSpeed:
                                                                              windspeed,
                                                                          humidity:
                                                                              humidity,
                                                                          recommendation:
                                                                              recommendation,
                                                                          waving:
                                                                              waving,
                                                                          ph:
                                                                              ph,
                                                                          isNegative: siteStatusCtrl
                                                                              .isNegative,
                                                                          imge: imgCtrl
                                                                              .image,
                                                                          imge2: imgCtrl
                                                                              .image2,
                                                                          insectExplorationId:
                                                                              id)
                                                                      .then(
                                                                          (value) {
                                                                    if (value ==
                                                                        400) {
                                                                      toast(
                                                                          'there is an error in sending'.tr,
                                                                          duration:
                                                                              const Duration(seconds: 2));
                                                                      clk.changeClick();
                                                                    } else if (value ==
                                                                        401) {
                                                                      Get.offAll(
                                                                          const LoginScreen());
                                                                    } else if (value ==
                                                                        200) {
                                                                      Get.offAll(
                                                                          () =>
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
                                                                            'sent succesfully'.tr,
                                                                        confirmBtnText:
                                                                           'ok'.tr,
                                                                           confirmBtnTextStyle: const TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,),
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
                                                                clk.changeClick();
                                                              }
                                                            });
                                                          }
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
                                                          ?  Text(
                                                              "Add visit Insect Exploration".tr,
                                                              style:const TextStyle(
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
                      label:'add first picture'.tr,
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
                openIcon: Icons.add_photo_alternate,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
              );
            }));
  }
}
