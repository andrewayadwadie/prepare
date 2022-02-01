import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/prepareControllers/devices_controllers.dart';
import 'package:prepare/utils/style.dart';

class SingleDevicesTextField extends StatelessWidget {
  const SingleDevicesTextField({Key? key, required this.label}) : super(key: key);

  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "نوع الجهاز   : ",
            style: TextStyle(color: primaryColor),
          ),
          GetBuilder<DevicesController>(

            builder: (controller) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 25,
                child: TextFormField(
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
                  onSaved: (val) {
                    controller.getdevicesCount(int.parse(val??""));
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
