import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/controller/site_status_controller.dart';

// ignore: must_be_immutable
class SiteStatusWidget extends StatelessWidget {
  SiteStatusWidget({Key? key}) : super(key: key);
  bool isNegative = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SiteStatusController>(
        init: SiteStatusController(),
        builder: (controller) {
          return Column(
            children: <Widget>[
              RadioListTile<bool>(
                title:  Text('site is positive'.tr),
                value: true,
                groupValue: controller.isNegative,
                onChanged: (bool? value) => controller.onChanged(value),
              ),
              RadioListTile<bool>(
                title:  Text('site is negative'.tr),
                value: false,
                groupValue: controller.isNegative,
                onChanged: (bool? value) => controller.onChanged(value),
              ),
            ],
          );
        });
  }
}
