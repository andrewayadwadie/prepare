import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/tools_controller.dart';
import 'package:prepare/utils/style.dart';

class SingleToolTextField extends StatelessWidget {
  const SingleToolTextField({Key? key, required this.label}) : super(key: key);

  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "إسم الاداة : ",
            style: TextStyle(color: primaryColor),
          ),
          GetBuilder<ToolsController>(

            builder: (controller) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 25,
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: primaryColor,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: primaryColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      labelText: label,
                      hintText: label,
                      floatingLabelStyle: const TextStyle(fontSize: 9),
                      hintStyle: const TextStyle(fontSize: 9),
                      labelStyle:
                          const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)
                      //enabledBorder: InputBorder.none
                      ),
                  onChanged: (val) {
                    controller.gettoolsCount(int.parse(val));
                  },
                  // enabledBorder: InputBorder.none,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}