import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class ToolsDialogWidget extends StatelessWidget {
  ToolsDialogWidget({Key? key, 
  required this.title, 
  required this.label, 
  required this.emptyErrorText}) : super(key: key);

  final String title;
  final String label;
  final String emptyErrorText;

  final _toolsFormKey = GlobalKey<FormState>();
  String? tools ;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
             Center(
              child: Text(
               title,
                style:const TextStyle(
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
            Form(
              key: _toolsFormKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: label,
                          hintText: label,
                          labelStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)
                          //enabledBorder: InputBorder.none
                          ),
                      onSaved: (val) {
                        tools = val;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emptyErrorText;
                        } else {
                          return null;
                        }
                      }, // enabledBorder: InputBorder.none,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_toolsFormKey.currentState!.validate()) {
                        _toolsFormKey.currentState!.save();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
