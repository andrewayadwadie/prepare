import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/project_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/display_prepare_screen.dart';
import 'package:prepare/view/prepare/prepare_screen.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({Key? key}) : super(key: key);

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
                                  return controller.projects.isEmpty
                                      ? Container(
                                          margin: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/empty_product_banner.c076afe7.png"),
                                                  fit: BoxFit.contain)),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              top: 16, right: 5, left: 5),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                            color: offwhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                                spreadRadius: 2,
                                                blurRadius: 4,
                                                offset: const Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: IntrinsicWidth(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: Text(
                                                      controller
                                                          .projects[index].name,
                                                      style: const TextStyle(
                                                          color:
                                                              lightPrimaryColor,
                                                          fontFamily:
                                                              "hanimation",
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                if (controller.projects[index]
                                                        .status ==
                                                    0)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          PrepareScreen(
                                                              id: controller
                                                                  .projects[
                                                                      index]
                                                                  .id,
                                                              title: controller
                                                                  .projects[
                                                                      index]
                                                                  .name));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            6,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            30,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                lightPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9)),
                                                        child: const Text(
                                                          "تحضير",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'hanimation',
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (controller.projects[index]
                                                        .status ==
                                                    1)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          DisplayPrepareScreen(
                                                              id: controller
                                                                  .projects[
                                                                      index]
                                                                  .id,
                                                              title: controller
                                                                  .projects[
                                                                      index]
                                                                  .name));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            6,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            30,
                                                        decoration: BoxDecoration(
                                                            color: redColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9)),
                                                        child: const Text(
                                                          "عرض التحضير",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'hanimation',
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                const Spacer()
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
