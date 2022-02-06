import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:prepare/core/controller/epicenter/all_insects_controller.dart';
import 'package:prepare/core/controller/epicenter/visit_epicenter_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';

import 'package:prepare/view/bug_discover/widgets/humidity_widget.dart';
import 'package:prepare/view/bug_discover/widgets/recommendation_widget.dart';
import 'package:prepare/view/bug_discover/widgets/temperature_widget.dart';
import 'package:prepare/view/bug_discover/widgets/windspeed_widget.dart';

import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';
import 'package:prepare/view/visit_epicenter/widgets/all_epicenter_widget.dart';

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
                    //==========================================
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    // Send Report button
                    GetBuilder<InternetController>(
                        init: InternetController(),
                        builder: (net) {
                          return GetBuilder<VisitEpicenterController>(
                              init: VisitEpicenterController(),
                              builder: (insectCtrl) {
                                return InkWell(
                                  onTap: () async {
                                    if (recommendation == "") {
                                      toast("برجاء إدخال  ملاحظات",
                                          duration: const Duration(seconds: 2));
                                    }else if (humidity == 0.0) {
                                      toast("برجاء إدخال  قيمة الرطوبة",
                                          duration: const Duration(seconds: 2));
                                    } 
                                    else if (windspeed == 0.0) {
                                      toast("برجاء إدخال  سرعة الرياح ",
                                          duration: const Duration(seconds: 2));
                                    }
                                    else if (temperature == 0.0) {
                                      toast("برجاء إدخال  درجة الحرارة ",
                                          duration: const Duration(seconds: 2));
                                    }
                                  
                                    
                                    else if(insectCtrl.epicenterText == "إختر البؤرة"){
                                      toast("برجاء إختيار البؤرة ",
                                          duration: const Duration(seconds: 2));
                                    }
                                    else {
                                      net.checkInternet().then((val) {
                                        if (val) {

                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
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
                                    ),
                                    child: const Text(
                                      "إضافة بؤرة ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              });
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
