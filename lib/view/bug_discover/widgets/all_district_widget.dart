import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';

class AllDistrictWidget extends StatelessWidget {
  const AllDistrictWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    log("id from district id widget : $id");
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GetX<AllDistrictController>(
            init: AllDistrictController(),
            builder: (disCtrl) {
              return GetBuilder<InternetController>(
                  init: InternetController(),
                  builder: (net) {
                    return GestureDetector(
                        onTap: () {
                          net.checkInternet().then((val) {
                            if (val) {
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) =>
                                    //  disCtrl.loading == true
                                    //     ? const LoaderWidget()
                                    //     :
                                    SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: ListView.builder(
                                      itemCount: disCtrl.district.length,
                                      itemBuilder: (context, index) {
                                        log("disCtrl.district.length : ${disCtrl.district.length}");
                                        return disCtrl.district.isEmpty
                                            ? Image.asset(
                                                "assets/images/empty_product_banner.c076afe7.png",
                                                fit: BoxFit.contain,
                                                width: 100,
                                                height: 100,
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  disCtrl.onTapSelected(
                                                      ctx,
                                                      disCtrl
                                                          .district[index].id,
                                                      index);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 60,
                                                      vertical: 15),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            12,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.grey)),
                                                    child: Text(
                                                      disCtrl
                                                          .district[index].name,
                                                      style: const TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              );
                                      }),
                                ),
                              );
                            }
                          });
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
                                disCtrl.districtText.value,
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
                        ));
                  });
            }));
  }
}
