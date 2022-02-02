import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class BugDiscoverScreen extends StatelessWidget {
  BugDiscoverScreen({
    Key? key,
  }) : super(key: key);

  static int noticeClassifyId = 1;

  final _reportFormKey = GlobalKey<FormState>();

////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HawkFabMenu(
      openIcon: Icons.add,
      blur: 0.5,
      fabColor: Colors.yellow,
      iconColor: primaryColor,
      closeIcon: Icons.close,
      items: [
        HawkFabMenuItem(
            label: 'إضافة الصورة الأولى',
            ontap: () {},
            icon: const Icon(Icons.image),
            color: primaryColor,
            labelColor: lightPrimaryColor,
            labelBackgroundColor: Colors.white),
        HawkFabMenuItem(
            label: 'إلتقط الصورة الأولى ',
            ontap: () {},
            icon: const Icon(Icons.add_a_photo),
            color: primaryColor,
            labelColor: lightPrimaryColor,
            labelBackgroundColor: Colors.white),
        HawkFabMenuItem(
            label: 'إضافة الصورة الثانية',
            ontap: () {},
            icon: const Icon(Icons.image),
            color: primaryColor,
            labelColor: lightPrimaryColor,
            labelBackgroundColor: Colors.white),
        HawkFabMenuItem(
            label: 'إلتقط الصورة الثانية',
            ontap: () {},
            icon: const Icon(Icons.add_a_photo),
            color: primaryColor,
            labelColor: lightPrimaryColor,
            labelBackgroundColor: Colors.white),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _reportFormKey,
            child: Column(
              children: [
                const HeaderWidget(arrow: true),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                const AutoSizeText(
                  "الإستكشاف الحشري ",
                  style: TextStyle(
                      color: lightPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const LineDots(),
                Container(
                  height: MediaQuery.of(context).size.height / 1.68,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    children: [
                      //<<<<<<<<<<<<<<<<<<String Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //====== street ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "اسم الشارع ",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "اسم الشارع : ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال اسم الشارع  ';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //====== ph ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "ph",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "ph: ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال ph ';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //====== Recommendation  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "ملاحظات ",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "ملاحظات : ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال ملاحظات  ';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //<<<<<<<<<<<<<<<<<<double Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //====== windspeed  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "سرعة الرياح",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "سرعة الرياح: ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال سرعة الرياح ';
                              } else if (value.runtimeType != int ||
                                  value.runtimeType != double ||
                                  value.runtimeType != num) {
                                return 'برجاء ادخال عدد وليس حروف';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //====== temperature  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "درجة الحرارة",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "درجة الحرارة: ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال درجة الحرارة ';
                              } else if (value.runtimeType != int ||
                                  value.runtimeType != double ||
                                  value.runtimeType != num) {
                                return 'برجاء ادخال عدد وليس حروف';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //====== humidity  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "الرطوبة",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "الرطوبة: ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال الرطوبة ';
                              } else if (value.runtimeType != int ||
                                  value.runtimeType != double ||
                                  value.runtimeType != num) {
                                return 'برجاء ادخال عدد وليس حروف';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //====== waving  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 13,
                          child: TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              //========error================
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: redColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 6),
                              errorStyle: const TextStyle(fontSize: 8),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
                              //============================================
                              // =========border ===================================
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //============================================
                              // =========label ===================================
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              floatingLabelStyle: const TextStyle(fontSize: 11),
                              labelText: "درجة الملوحة ",
                              labelStyle: const TextStyle(
                                  height: 1.1,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              //============================================
                              // =========hint ===================================
                              //hintText: "درجة الملوحة : ",
                              hintStyle: const TextStyle(fontSize: 10),

                              //enabledBorder: InputBorder.none
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء إدخال درجة الملوحة  ';
                              } else if (value.runtimeType != int ||
                                  value.runtimeType != double ||
                                  value.runtimeType != num) {
                                return 'برجاء ادخال عدد وليس حروف';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      //<<<<<<<<<<<<<<<<<<Dropdown Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      //====== idstrictId ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.centerRight,
                              // width:
                              //     MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "رقم الحي",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: blackColor),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: blackColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      //====== flyTypeId  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.centerRight,
                              // width:
                              //     MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "نوع الموقع ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: blackColor),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: blackColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      //====== flynoteId  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.centerRight,
                              // width:
                              //     MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "نوع الملاحظة ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: blackColor),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: blackColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      //====== flySampleTypeId  ==========
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.centerRight,
                              // width:
                              //     MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "نوع العينة ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: blackColor),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: blackColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                    ],
                  ),
                ),
                // Send Report button
                InkWell(
                  onTap: () {
                    if (_reportFormKey.currentState!.validate()) {
                      _reportFormKey.currentState!.save();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 17,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                          colors: [
                            lightPrimaryColor,
                            primaryColor,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: const Text(
                      "إرسال الإستكشاف ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
