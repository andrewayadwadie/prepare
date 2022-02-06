import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prepare/core/controller/bug_dicover/all_cities_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';
import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';

class AllCitiesWidget extends StatelessWidget {
  const AllCitiesWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AllCitiesController controller;

  @override
  Widget build(BuildContext context) {
    // AllDistrictController dis = Get.put(AllDistrictController(controller.cityId.value));
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => controller.loading == true
                    ? const LoaderWidget()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: ListView.builder(
                            itemCount: controller.cities.length,
                            itemBuilder: (context, index) {
                              return GetBuilder<AllDistrictController>(
                                  init: AllDistrictController(),
                                  builder: (disCtrl) {
                                    return InkWell(
                                      onTap: () {
                                        log("TokenPref.getTokenValue : ${TokenPref.getTokenValue()}");
                                        controller.onTapSelected(
                                            ctx, controller.cities[index].id);
                                        disCtrl.getDistrictCount(
                                            disId: controller.cityId.value);
                                        //  dis.getDistrictCount(controller.cityId.value);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 60, vertical: 15),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          child: Text(
                                            controller.cities[index].name,
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 7),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerRight,
              // width:
              //     MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 16,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    controller.cityText.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        height: 1.1,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: blackColor,
                    size: 30,
                  ),
                ],
              ),
            )));
  }
}
