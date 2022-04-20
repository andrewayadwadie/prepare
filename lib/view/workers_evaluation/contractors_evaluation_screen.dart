import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controller/click_controller.dart';

import '../../core/controller/evaluation_controller/evaluation_controller.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../core/service/contractors_services.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';
import 'widgets/list_item_widget.dart';

// ignore: must_be_immutable
class WorkersEvaluation extends StatelessWidget {
  const WorkersEvaluation({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;
  //final _itemForm = GlobalKey<FormState>();
//  final List<GlobalKey<FormState>> itemFormKey = [];

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
                height: MediaQuery.of(context).size.height / 50,
              ),
              AutoSizeText(
                'Contractors evaluation'.tr,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontFamily: 'hanimation'),
              ),
              const LineDots(),
              // const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetBuilder<Evaluate>(
                      init: Evaluate(),
                      builder: (evaCtrl) {
                        return InkWell(
                          onTap: () {
                            evaCtrl.increaseList();
                            //   evaCtrl.data.length++;
                            //         log("data : ${evaCtrl.data}");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                              color: yellowColor,
                              border: Border.all(color: Colors.white, width: 2),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: lightPrimaryColor,
                                ),
                                Text(
                                  'Add an assessment'.tr,
                                  style: const TextStyle(
                                      color: lightPrimaryColor, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  /*
                  GetBuilder<Evaluate>(
                      init: Evaluate(),
                      builder: (evaCtrl) {
                        return InkWell(
                          onTap: () {
                            if (evaCtrl.evaluateList.length != item.length) {
                              Get.snackbar("يوجد خطأ",
                                  "برجاء إدخال بند اولاً قبل الاضافة");
                            } else if (evaCtrl.evaluateList.length !=
                                recommendation.length) {
                              Get.snackbar("يوجد خطأ",
                                  "برجاء إدخال وصف اولاً قبل الاضافة");
                             } else {
                                      evaCtrl.decreaseList();
                            item.removeLast();
                            recommendation.removeLast();
                            }
                            //  if (itemFormKey.last.currentState!.validate()) {
                    
                            // }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                              color: redColor,
                              border: Border.all(color: Colors.white, width: 2),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                Text(
                                  "حذف تقييم",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      */
                  GetBuilder<Evaluate>(
                      init: Evaluate(),
                      builder: (evaCtrl) {
                        return GetBuilder<InternetController>(
                            init: InternetController(),
                            builder: (net) {
                              return GetBuilder<ClickController>(
                                  init: ClickController(),
                                  builder: (click) {
                                    return InkWell(
                                      onTap: () {
                                        net.checkInternet().then((value) {
                                          if (value) {
                                            if (click.clicked == false) {
                                              log("message ${evaCtrl.evaluateList}");
                                              log("id $id");
                                              ContractrosServices.addEvaluation(
                                                      contractorId: id,
                                                      rates:
                                                          evaCtrl.evaluateList)
                                                  .then((value) {
                                                if (value == 200) {
                                                  Get.offAll(
                                                      const HomeScreen());
                                                  CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.success,
                                                    title:
                                                        'Evaluations has been successfully sended'
                                                            .tr,
                                                    onConfirmBtnTap: () {
                                                      Get.back();
                                                    },
                                                    confirmBtnText: "ok".tr,
                                                    confirmBtnColor:
                                                        lightPrimaryColor,
                                                    backgroundColor:
                                                        lightPrimaryColor,
                                                  );
                                                } else if (value == 401) {
                                                  Get.offAll(
                                                      const LoginScreen());
                                                } else if (value.runtimeType ==
                                                    String) {
                                                  Get.snackbar(
                                                      'there is an error in sending'
                                                          .tr,
                                                      value,
                                                      duration: const Duration(
                                                          seconds: 3));
                                                } else if (value == 500) {
                                                  Get.snackbar(
                                                      'error',
                                                      'there is an error in sending'
                                                          .tr,
                                                      duration: const Duration(
                                                          seconds: 3));
                                                } else {
                                                  Get.snackbar(
                                                      'error',
                                                      'there is an error in sending'
                                                          .tr,
                                                      duration: const Duration(
                                                          seconds: 3));
                                                }
                                              });

                                              click.changeClick();
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        decoration: BoxDecoration(
                                          color: lightPrimaryColor,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: click.clicked == false
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Send evaluations'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  ),
                                                  const Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              )
                                            : const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                      ),
                                    );
                                  });
                            });
                      }),
                ],
              ),

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
                child: GetX<Evaluate>(
                    init: Evaluate(),
                    builder: (ctrl) {
                      return ListView.builder(
                          itemCount: ctrl.evaluateList.length,
                          itemBuilder: (context, index) {
                            return ListItemWidget(
                              index: index,
                              itemController: ctrl.textEditItemList[index],
                              disController: ctrl.textEditDisList[index],
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
