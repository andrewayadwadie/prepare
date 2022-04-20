import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/prepareControllers/pestsides_controllers.dart';
import '../../../core/controller/prepareCountController/pestside_count_controller.dart';
import '../../../utils/style.dart';
import 'single_pestside_textfield.dart';
import '../../shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class PesticidesDialogWidget extends StatelessWidget {
  PesticidesDialogWidget(
      {Key? key,
      required this.title,
      required this.label,
      required this.emptyErrorText,
      required this.exterminators
      })
      : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;
  final List exterminators;

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
            child: GetBuilder<PestSideCountController>(
              init: PestSideCountController(),
              builder: (controller) {
                return ListView.builder(
                    itemCount:  exterminators.length,
                    itemBuilder: (context, index) {
                      return SinglePestSideTextField(
                        id: exterminators[index]["id"],
                        count: exterminators[index]["quantity"],
                        label: label,
                        title: exterminators[index]["name"],
                        );
                    });
              }
            )),
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
