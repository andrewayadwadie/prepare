import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controller/prepareControllers/pestsides_controllers.dart';
import '../../../utils/style.dart';

class SinglePestSideTextField extends StatelessWidget {
  const SinglePestSideTextField({Key? key, required this.label, required this.title,required this.id , required this.count}) : super(key: key);

  final String label;
  final String title;
  final int id;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height/9,
              width: MediaQuery.of(context).size.width/3,
             child: Text(
              title.toString() ,
              style:const TextStyle(color: primaryColor),
          ),
           ),
          GetBuilder<PestsidesController>(

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
                    controller.getpestsidesCount(int.parse(val == "" || val ==null  ? "0":val));
                    controller.addPestSideObject(id, int.parse(val == "" || val ==null  ? "0":val));
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
