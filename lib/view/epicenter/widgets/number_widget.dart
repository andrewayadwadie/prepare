import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/style.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({Key? key,  required this.onChange}) : super(key: key);
 
final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 13,
        child: TextFormField(
 
          cursorHeight: 20,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            //========error================
            focusedErrorBorder: OutlineInputBorder(
                borderSide:  const BorderSide(color: redColor, width: 2.0),
                borderRadius: BorderRadius.circular(5),
                gapPadding: 6),
            errorStyle: const TextStyle(fontSize: 8),
            contentPadding: const EdgeInsets.only(bottom: 15, right: 10),
            //============================================
            // =========border ===================================
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            //============================================
            // =========label ===================================
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: const TextStyle(fontSize: 11),
            labelText: "${'number of Insects'.tr} :  ",
            labelStyle: const TextStyle(
                height: 1.1,
                color: blackColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            //============================================
            // =========hint ===================================
            //hintText: "عدد الحشرات  :  ",
            hintStyle: const TextStyle(fontSize: 10),

            //enabledBorder: InputBorder.none
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please enter number of Insects'.tr;
            }
            return null;
          },
          onChanged:onChange,
        ),
      ),
    );
  }
}
