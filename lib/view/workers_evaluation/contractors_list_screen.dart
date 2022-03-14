import 'package:flutter/material.dart';
import 'package:prepare/core/controller/evaluation_controller/contractors_list_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';
import 'package:get/get.dart';

import 'contractors_evaluation_screen.dart';

class ContractorsListScreen extends StatelessWidget {
  const ContractorsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.031,
          child: GetBuilder<ContractorsListController>(
              init: ContractorsListController(),
              builder: (controller) {
                return Column(
                  children: [
                    const HeaderWidget(arrow: true),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                      'Contractors List'.tr,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontFamily: 'hanimation'),
                    ),
                    const LineDots(),
                    const Spacer(),
                      // controller.errorNo > 0?
                      //   SizedBox(
                      //   width: 100,
                      //   height: 100,
                      //   child: Text(
                      //     "error ${controller.errorNo}",
                      //     style: const TextStyle(color: Colors.red, fontSize: 20),
                      //   ),
                      // ):
                    Container(
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
                                itemCount: controller.contractors.length,
                                itemBuilder: (context, index) {
                                  return controller.contractors.isEmpty
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
                                              10,
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
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.6,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: SingleChildScrollView(
                                                      child: Text(
                                                    controller
                                                        .contractors[index]
                                                        .name,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        height: 1.2,
                                                        color:
                                                            lightPrimaryColor,
                                                        fontFamily:
                                                            "hanimation",
                                                        fontSize: 15),
                                                  )),
                                                ),
                                                GetBuilder<InternetController>(
                                                    init: InternetController(),
                                                    builder: (net) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          net
                                                              .checkInternet()
                                                              .then((value) {
                                                            if (value) {
                                                              // index ==0? Get.to(  const MapBoxScreen()):
                                                              Get.to(WorkersEvaluation(
                                                                  id: controller
                                                                      .contractors[
                                                                          index]
                                                                      .id));
                                                            }
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 13,
                                                                  bottom: 13,
                                                                  right: 10),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                5,
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
                                                            child: Text(
                                                              'evaluate contractor'
                                                                  .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'hanimation',
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
                                })),
                  
                  ],
                );
              }),
        ),
      )),
    );
  }
}
