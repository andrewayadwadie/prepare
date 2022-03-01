import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/daily_work/daily_work_screen.dart';
import 'package:prepare/view/mapbox/mapbox_screen.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

class DailyWorkMainScreen extends StatelessWidget {
  const DailyWorkMainScreen({Key? key}) : super(key: key);

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
                const Text(
                  "المهام اليومية ",
                  style: TextStyle(
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
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              const EdgeInsets.only(top: 16, right: 5, left: 5),
                          height: MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(
                            color: offwhiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IntrinsicWidth(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: ListView(children: const [
                                      Text(
                                        """
المهمة اليومية 
البلدية : العزيزية 
حي : انس بن مالك
                                              """,
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1.2,
                                            color: lightPrimaryColor,
                                            fontFamily: "hanimation",
                                            fontSize: 15),
                                      )
                                    ]),
                                  ),
                                ),
                                GetBuilder<InternetController>(
                                    init: InternetController(),
                                    builder: (net) {
                                      return GestureDetector(
                                        onTap: () {
                                          net.checkInternet().then((value) {
                                            if (value) {
                                            index ==0? Get.to(  const MapBoxScreen()):
                                             Get.to(  DailyWorkScreen());
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, bottom: 13, right: 10),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            decoration: BoxDecoration(
                                                color: lightPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: const Text(
                                              "بدء المسار",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'hanimation',
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                const Spacer()
                              ],
                            ),
                          ),
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
