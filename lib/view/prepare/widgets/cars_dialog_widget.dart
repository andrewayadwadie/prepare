import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/cars_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/widgets/single_car_textfield.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class CarsDialogWidget extends StatelessWidget {
  CarsDialogWidget(
      {Key? key,
      required this.title,
      required this.label,
      required this.emptyErrorText})
      : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;

  final _carsFormKey = GlobalKey<FormState>();
 

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
        key: _carsFormKey,
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: 300,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return SingleCarTextField(label: label);
                })),
      ),
      actions: [
        GetBuilder<CarsController>(
            init: CarsController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (_carsFormKey.currentState!.validate()) {
                    _carsFormKey.currentState!.save();
                  //  controller.getCarsCount(cars);
                    Get.back();
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
      ],
    );
  }
}
