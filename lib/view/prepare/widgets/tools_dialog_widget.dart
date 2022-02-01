import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/tools_controller.dart';
import 'package:prepare/core/controller/prepareCountController/tools_count_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/widgets/single_tools_textfield.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class ToolsDialogWidget extends StatelessWidget {
  ToolsDialogWidget(
      {Key? key,
      required this.title,
      required this.label,
      required this.emptyErrorText})
      : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;

  final _toolsFormKey = GlobalKey<FormState>();
  String? tools;

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
      content:Form(
        key: _toolsFormKey,
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: 300,
            child: GetBuilder<ToolsCountController>(
              init: ToolsCountController(),
              builder: (controller) {
                return ListView.builder(
                    itemCount: controller.tools.length,
                    itemBuilder: (context, index) {
                      return SingleToolTextField(label: label,title: controller.tools[index].name,);
                    });
              }
            )),
      ),
      actions: [
        GetBuilder<ToolsController>(
            init: ToolsController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (_toolsFormKey.currentState!.validate()) {
                    _toolsFormKey.currentState!.save();
                    //  controller.gettoolsCount(tools??"0");
                    Get.back();
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10,  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                      color: lightPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "تحضير ",
                    style: TextStyle(
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
            margin: const EdgeInsets.symmetric(horizontal: 10, ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4.5,
            height: MediaQuery.of(context).size.height / 16,
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "إلغاء ",
              style: TextStyle(
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
