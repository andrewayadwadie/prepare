import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/pestsides_controllers.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/widgets/single_pestside_textfield.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class PesticidesDialogWidget extends StatelessWidget {
  PesticidesDialogWidget(
      {Key? key,
      required this.title,
      required this.label,
      required this.emptyErrorText})
      : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;

  final _pesticidesFormKey = GlobalKey<FormState>();
  String? pesticides;

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
        key: _pesticidesFormKey,
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: 300,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return SinglePestSideTextField(label: label);
                })),
      ),
      actions: [
        GetBuilder<PestsidesController>(
            init: PestsidesController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (_pesticidesFormKey.currentState!.validate()) {
                    _pesticidesFormKey.currentState!.save();
                    //  controller.getpestsidesCount(pesticides??"0");
                    Get.back();
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
            })
      ],
    );
  }
}
