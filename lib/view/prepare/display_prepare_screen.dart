import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controller/prepareControllers/user_prepration_controller.dart';
import '../../utils/style.dart';
import '../shared_widgets/custom_loader.dart';
import '../shared_widgets/header_widget.dart';
import '../shared_widgets/line_dot.dart';
import 'widgets/single_list_item_widget.dart';

// ignore: must_be_immutable
class DisplayPrepareScreen extends StatelessWidget {
  const DisplayPrepareScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  final int id;
  final String title;

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
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                  height: MediaQuery.of(context).size.height / 1.47,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: GetBuilder<UserPreprationController>(
                    init: UserPreprationController(id),
                    builder: (controller) {
                      return 
                      
                      controller.loading==true?
                     const  LoaderWidget():
                      ListView(
                        children: [
                          //==================================
                          //============== cars ==============
                          //==================================

                          SingleListItem(title: 'vehicles count'.tr, count:"${ controller.data.numberOfVehicles}"),

                          //==================================
                          //============== tools ==============
                          //==================================
                     //     SingleListItem(title: 'tools count'.tr, count: "${ controller.data.numberOfTools}"),
                          //==================================
                          //============== devices ==============
                          //==================================
                          SingleListItem(title: 'devices count'.tr, count: "${ controller.data.numberOfDevices}"),
                          //==================================
                          //============== pesticides ==============
                          //==================================
                          SingleListItem(title: 'pesticide quantity'.tr, count: "${ controller.data.quantityOfExterminator}"),
                          //==================================
                          //============== Team ==============
                          //==================================
                          SingleListItem(title: 'team count'.tr, count: "${ controller.data.numberOfEmployees}"),
                          //============== ************* ==============
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          //==================================
                          //============== submit ==============
                          //==================================
                          InkWell(
                            onTap: () {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'The project has been prepared'.tr,
                                text: 'The project cannot be prepared again'.tr,
                                onConfirmBtnTap: () {
                                  Get.back();
                                },
                                confirmBtnText: 'ok'.tr,
                                 confirmBtnTextStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.normal),
                                confirmBtnColor: lightPrimaryColor,
                                backgroundColor: lightPrimaryColor,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child:   Text(
                                'prepare'.tr,
                                style:const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'hanimation',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
