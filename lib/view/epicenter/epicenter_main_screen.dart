import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/epicenter/epicenter_map/epicenter_map_screen.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

import 'epicenter_screen.dart';

class EpicCenterMainScreen extends StatelessWidget {
  EpicCenterMainScreen({Key? key}) : super(key: key);
  final List<String> titles = [
    "إضافة بؤرة",
    //  "زيارة بؤرة",
    "الذهاب إلى بؤرة"
  ];
  final List<Widget> screens = [
    EpiCenterScreen(),
    //  VisitEpicenterScreen(),
    EpiCenterMapScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(arrow: true),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const AutoSizeText(
              "بؤرة ذباب وبعوض",
              style: TextStyle(
                  color: lightPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const LineDots(),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
              padding: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GridView.builder(
                  padding:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: 2,
                  itemBuilder: (BuildContext ctx, index) {
                    return GetBuilder<InternetController>(
                      init:InternetController() ,
                      builder: (net) {
                      return InkWell(
                        onTap: () {
                          net.checkInternet().then((value) {
                            if (value) {
                              Get.to(screens[index]);
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 1, color: lightPrimaryColor),
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 6,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 7),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 9,
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                  "assets/images/b$index.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 22,
                                decoration: const BoxDecoration(
                                    color: lightPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  titles[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'hanimation',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }),
            )
          ],
        ),
      )),
    );
  }
}
