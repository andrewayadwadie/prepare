import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/site_status_controller.dart';

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
                title: const Text('الموقع إيجابي'),
                value: true,
                groupValue: controller.isNegative,
                onChanged: (bool? value) => controller.onChanged(value),
              ),
              RadioListTile<bool>(
                title: const Text('الموقع سلبي'),
                value: false,
                groupValue: controller.isNegative,
                onChanged: (bool? value) => controller.onChanged(value),
              ),
            ],
          );
        });
  }
}
