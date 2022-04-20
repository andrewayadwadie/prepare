import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/evaluation_controller/evaluation_controller.dart';
import '../../../utils/style.dart';

import 'item_widget.dart';
import 'recommendation_widget.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    required this.index,
    required this.itemController,
    required this.disController
  }) : super(key: key);
  final int index;
  final TextEditingController itemController ;
  final TextEditingController disController ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Evaluate>(
        init: Evaluate(),
        builder: (ctrl) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: lightPrimaryColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              //   key: itemFormKey[index],
              child: Column(
                children: [
                  ItemWidget(
                    controller: itemController,
                    onChange: (value) {
                 //   ctrl.data.clear();
                // ctrl.addData(index,item: value??"");

                    ctrl.addItem(index,item: value??"");
                  }),
                  WorkRecommendationWidget(
                    controller: disController,
                    onChange: (val) {
                  //  ctrl.data.clear();
               //    ctrl.addData(index,description: val);
                   ctrl.addDescription(index,dis: val);
                  }),
                  GetBuilder<Evaluate>(
                      init: Evaluate(),
                      builder: (ctrll) {
                        return GestureDetector(
                          onTap: () {
                            log("index from view $index");
                            ctrll.decreaseList(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2.8,
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
                              children:  [
                                const Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Delete evaluation'.tr,
                                  style:const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }
}
