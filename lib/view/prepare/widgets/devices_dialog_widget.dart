import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/prepareControllers/devices_controllers.dart';
import '../../../core/controller/prepareCountController/devices_count_controller.dart';
import '../../../utils/style.dart';
import '../../shared_widgets/line_dot.dart';

import 'single_devices_textfield.dart';

// ignore: must_be_immutable
class DevicesDialogWidget extends StatelessWidget {
  DevicesDialogWidget(
      {Key? key,
      required this.title,
      required this.label,
      required this.emptyErrorText,
      required this.devices})
      : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;
  final List devices;

  final _devicesFormKey = GlobalKey<FormState>();
 // String? devices;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: lightPrimaryColor,
                  fontFamily: 'hanimation',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const LineDots(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      content: Form(
        key: _devicesFormKey,
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: 300,
            child: GetBuilder<DevicesCountController>(
              init: DevicesCountController(),
              builder: (controller) {
                return ListView.builder(
                    itemCount:  devices.length,
                    itemBuilder: (context, index) {
                      return SingleDevicesTextField(
                        id: devices[index]['id'],
                        count: devices[index]['count'],
                        label: label,
                        title: devices[index]['name'],
                        );
                    });
              }
            )),
      ),
      actions: [
        GetBuilder<DevicesController>(
            init: DevicesController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (_devicesFormKey.currentState!.validate()) {
                    _devicesFormKey.currentState!.save();
                    //  controller.getdevicesCount(devices);
                    Get.back();
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10 ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                      color: lightPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child:  Text(
                     'prepare'.tr,
                    style:const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'hanimation',
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10 ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4.5,
            height: MediaQuery.of(context).size.height / 16,
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(10)),
            child:  Text(
               "cancel".tr,
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
}
