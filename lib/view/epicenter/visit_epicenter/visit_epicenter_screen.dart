import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prepare/core/controller/click_controller.dart';

import 'package:prepare/core/controller/epicenter/visit_epicenter_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/core/service/all_epicenter_services.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';

import 'package:prepare/view/bug_discover/widgets/humidity_widget.dart';
import 'package:prepare/view/bug_discover/widgets/recommendation_widget.dart';
import 'package:prepare/view/bug_discover/widgets/temperature_widget.dart';
import 'package:prepare/view/bug_discover/widgets/windspeed_widget.dart';
import 'package:prepare/view/home/home_screen.dart';

import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

import 'widgets/all_epicenter_widget.dart';
 
// ignore: must_be_immutable
class VisitEpicenterScreen extends StatelessWidget {
  VisitEpicenterScreen({Key? key}) : super(key: key);

  final _visitEpicenterFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? recommendation;
  double? windspeed;
  double? temperature;
  double? humidity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _visitEpicenterFormKey,
          child: Column(
            children: <Widget>[
              const HeaderWidget(arrow: true),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const AutoSizeText(
                "زيارة بؤرة",
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
                    //====== Recommendation  ==========
                    RecommendationWidget(onChange: (value) {
                      recommendation = value;
                    }),
                    //====== AllEpicenterWidget  ==========
                    const AllEpicenterWidget(),
                  ],
                ),
              ),
              // Send Report button
              GetBuilder<InternetController>(
                  init: InternetController(),
                  builder: (net) {
                    return GetBuilder<VisitEpicenterController>(
                        init: VisitEpicenterController(),
                        builder: (insectCtrl) {
                          return GetBuilder<ClickController>(
                              init: ClickController(),
                              builder: (clk) {
                                return InkWell(
                                  onTap: () async {
                                    if (_visitEpicenterFormKey.currentState!
                                        .validate()) {
                                      _visitEpicenterFormKey.currentState!
                                          .save();

                                      if (clk.clicked == false) {
                                        if (recommendation == "") {
                                          toast("برجاء إدخال  ملاحظات",
                                              duration:
                                                  const Duration(seconds: 2));
                                          clk.changeClick();
                                        } else if (humidity == 0.0) {
                                          toast("برجاء إدخال  قيمة الرطوبة",
                                              duration:
                                                  const Duration(seconds: 2));
                                          clk.changeClick();
                                        } else if (windspeed == 0.0) {
                                          toast("برجاء إدخال  سرعة الرياح ",
                                              duration:
                                                  const Duration(seconds: 2));
                                          clk.changeClick();
                                        } else if (temperature == 0.0) {
                                          toast("برجاء إدخال  درجة الحرارة ",
                                              duration:
                                                  const Duration(seconds: 2));
                                          clk.changeClick();
                                        } else if (insectCtrl.epicenterText ==
                                            "إختر البؤرة") {
                                          toast("برجاء إختيار البؤرة ",
                                              duration:
                                                  const Duration(seconds: 2));
                                          clk.changeClick();
                                        } else {
                                          net.checkInternet().then((val) {
                                            if (val) {
                                              AllEpicenterServices
                                                      .addVisitEpiCenter(
                                                          temperature:
                                                              temperature
                                                                  .toString(),
                                                          windSpeed: windspeed
                                                              .toString(),
                                                          humidity: humidity
                                                              .toString(),
                                                          recommendation:
                                                              recommendation ??
                                                                  "",
                                                          epicenterId:
                                                              insectCtrl
                                                                  .epicenterId)
                                                  .then((value) {
                                                if (value == 200) {
                                                  Get.offAll(
                                                      () => const HomeScreen());
                                                  CoolAlert.show(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    title:
                                                        "تم إضافة زيارة بنجاح بنجاح",
                                                    confirmBtnText: "حسناً",
                                                    confirmBtnColor:
                                                        primaryColor,
                                                    backgroundColor:
                                                        primaryColor,
                                                    onConfirmBtnTap: () {
                                                      Get.back();
                                                    },
                                                  );
                                                }
                                                if (value.runtimeType ==
                                                    String) {
                                                  toast(value.toString(),
                                                      duration: const Duration(
                                                          seconds: 2));
                                                } else if (value == 401) {
                                                  Get.offAll(
                                                      const LoginScreen());
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
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: clk.clicked == false
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  lightPrimaryColor,
                                                  primaryColor,
                                                ],
                                                begin:
                                                    FractionalOffset(0.0, 0.0),
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
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),
                                    child: clk.clicked == false
                                        ? const Text(
                                            "إضافة زيارة بؤرة ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          )
                                        : const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                  ),
                                );
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
