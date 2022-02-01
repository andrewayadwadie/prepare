import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/project_controller.dart';

import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/prepare_screen.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

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
                const HeaderWidget(arrow: false),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                const Text(
                  "قائمة المشاريع ",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontFamily: 'hanimation'),
                ),
                const LineDots(),
                const Spacer(),
                GetBuilder<ProjectController>(
                    init: ProjectController(),
                    builder: (controller) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: controller.loading == true
                            ? const LoaderWidget()
                            : ListView.builder(
                                itemCount: controller.projects.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => PrepareScreen(
                                          id: controller.projects[index].id,
                                          title:
                                              controller.projects[index].name));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                        color: offwhiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            controller.projects[index].name,
                                            style: const TextStyle(
                                                color: lightPrimaryColor,
                                                fontFamily: "hanimation",
                                                fontSize: 16),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            decoration: BoxDecoration(
                                                color: lightPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: const Text(
                                              "تحضير",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'hanimation',
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
