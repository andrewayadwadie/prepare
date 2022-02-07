import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/cars_controller.dart';
import 'package:prepare/utils/style.dart';

class SingleCarTextField extends StatelessWidget {
  const SingleCarTextField({Key? key, required this.label,required this.title}) : super(key: key);

  final String label;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Text(
            "سيارة رقم $title : ",
            style:const TextStyle(color: primaryColor),
          ),
          GetBuilder<CarsController>(builder: (controller) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 25,
              child: TextFormField(
                keyboardType: TextInputType.number,
                cursorColor: primaryColor,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    labelText: label,
                    hintText: label,
                    floatingLabelStyle: const TextStyle(fontSize: 9),
                    hintStyle: const TextStyle(fontSize: 9),
                    labelStyle: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.bold)
                    //enabledBorder: InputBorder.none
                    ),
                onSaved: (val) {
                  controller.getCarsCount(int.parse(val == "" || val ==null  ? "0":val));
                },
                // enabledBorder: InputBorder.none,
              ),
            );
          }),
        ],
      ),
    );
  }
}
