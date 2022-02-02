import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:prepare/core/controller/bug_dicover/all_cities_controller.dart';
import 'package:prepare/core/controller/bug_dicover/all_district_controller.dart';
import 'package:prepare/core/controller/bug_dicover/fly_note_controller.dart';
import 'package:prepare/core/controller/bug_dicover/fly_sample_controller.dart';
import 'package:prepare/core/controller/bug_dicover/fly_type_controller.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/image_picker_controller.dart';
import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/custom_loader.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class BugDiscoverScreen extends StatelessWidget {
  BugDiscoverScreen({
    Key? key,
  }) : super(key: key);

  final _reportFormKey = GlobalKey<FormState>();

////////////////////////////////////////////
  String? street;
  String? ph;
  String? recommendation;
  //===============
  double? windspeed;
  double? temperature;
  double? humidity;
  double? waving;
////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ImagePickerController>(
            init: ImagePickerController(),
            builder: (imgCtrl) {
              return HawkFabMenu(
                openIcon: Icons.add,
                blur: 0.5,
                fabColor: Colors.yellow,
                iconColor: primaryColor,
                closeIcon: Icons.close,
                items: [
                  HawkFabMenuItem(
                      label: 'إضافة الصورة الأولى',
                      ontap: () {
                        imgCtrl.pickImageFromGallrey();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إلتقط الصورة الأولى ',
                      ontap: () {
                        imgCtrl.pickImageFromCam();
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إضافة الصورة الثانية',
                      ontap: () {
                        imgCtrl.pickImageFromGallrey2();
                      },
                      icon: const Icon(Icons.image),
                      color: primaryColor,
                      labelColor: lightPrimaryColor,
                      labelBackgroundColor: Colors.white),
                  HawkFabMenuItem(
                      label: 'إلتقط الصورة الثانية',
                      ontap: () {
                        imgCtrl.pickImageFromCam2();
                      },
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
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
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "إسم الشارع  ",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "إسم الشارع  : ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال إسم الشارع   ';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        street = value;
                                      },
                                    ),
                                  ),
                                ),
                                //====== ph ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "ph",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "ph: ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال ph ';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        ph = value;
                                      },
                                    ),
                                  ),
                                ),
                                //====== Recommendation  ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      maxLines: 3,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),

                                        labelText: "ملاحظات",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "ملاحظات : ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال ملاحظات  ';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        recommendation = value;
                                      },
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
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "سرعة الرياح",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "سرعة الرياح: ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال سرعة الرياح ';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        windspeed = double.parse(value ?? "");
                                      },
                                    ),
                                  ),
                                ),
                                //====== temperature  ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "درجة الحرارة",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "درجة الحرارة: ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال درجة الحرارة ';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        temperature = double.parse(value ?? "");
                                      },
                                    ),
                                  ),
                                ),
                                //====== humidity  ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "الرطوبة",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "الرطوبة: ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال الرطوبة ';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        humidity = double.parse(value ?? "");
                                      },
                                    ),
                                  ),
                                ),
                                //====== waving  ==========
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: TextFormField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        //========error================
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redColor, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 6),
                                        errorStyle:
                                            const TextStyle(fontSize: 8),
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        //============================================
                                        // =========border ===================================
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //============================================
                                        // =========label ===================================
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        floatingLabelStyle:
                                            const TextStyle(fontSize: 11),
                                        labelText: "درجة الملوحة ",
                                        labelStyle: const TextStyle(
                                            height: 1.1,
                                            color: blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        //============================================
                                        // =========hint ===================================
                                        //hintText: "درجة الملوحة : ",
                                        hintStyle:
                                            const TextStyle(fontSize: 10),

                                        //enabledBorder: InputBorder.none
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'برجاء إدخال درجة الملوحة  ';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        waving = double.parse(value ?? "");
                                      },
                                    ),
                                  ),
                                ),
                                //<<<<<<<<<<<<<<<<<<Dropdown Type >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //====== Cities  & District==========
                                GetBuilder<AllCitiesController>(
                                    init: AllCitiesController(),
                                    builder: (controller) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (ctx) => controller
                                                                .loading ==
                                                            true
                                                        ? const LoaderWidget()
                                                        : SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.5,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: controller
                                                                        .cities
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.onTapSelected(
                                                                              ctx,
                                                                              controller.cities[index].id);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 60,
                                                                              vertical: 15),
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 12,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                                                            child:
                                                                                Text(
                                                                              controller.cities[index].name,
                                                                              style: const TextStyle(color: primaryColor, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  // width:
                                                  //     MediaQuery.of(context).size.width / 2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      16,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        controller.cityText,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            height: 1.1,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: blackColor),
                                                      ),
                                                      const Spacer(),
                                                      const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: blackColor,
                                                        size: 30,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          //====== idstrictId ==========
                                          if (controller.cityText !=
                                              "إختر إسم المدينة")
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: GetBuilder<
                                                      AllDistrictController>(
                                                  init: AllDistrictController(
                                                      controller.cityId.value),
                                                  builder: (districtCtrl) {
                                                    return GestureDetector(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                districtCtrl.loading ==
                                                                        true
                                                                    ? const LoaderWidget()
                                                                    : SizedBox(
                                                                        height: MediaQuery.of(context).size.height /
                                                                            2.5,
                                                                        child: ListView.builder(
                                                                            itemCount: districtCtrl.district.length,
                                                                            itemBuilder: (context, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  districtCtrl.onTapSelected(ctx, districtCtrl.district[index].id);
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    height: MediaQuery.of(context).size.height / 12,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                                                                    child: Text(
                                                                                      districtCtrl.district[index].name,
                                                                                      style: const TextStyle(color: primaryColor, fontSize: 15),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 7),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      30),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          // width:
                                                          //     MediaQuery.of(context).size.width / 2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              16,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                districtCtrl
                                                                    .districtText,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    height: 1.1,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        blackColor),
                                                              ),
                                                              const Spacer(),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color:
                                                                    blackColor,
                                                                size: 30,
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  }),
                                            )
                                        ],
                                      );
                                    }),

                                //====== flyTypeId  ==========
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GetBuilder<AllFlyTypeController>(
                                      init: AllFlyTypeController(),
                                      builder: (controller) {
                                        return GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) =>
                                                    controller.loading == true
                                                        ? const LoaderWidget()
                                                        : SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.5,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: controller
                                                                        .flyType
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.onTapSelected(
                                                                              ctx,
                                                                              controller.flyType[index].id);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 60,
                                                                              vertical: 15),
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 12,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                                                            child:
                                                                                Text(
                                                                              controller.flyType[index].name,
                                                                              style: const TextStyle(color: primaryColor, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              alignment: Alignment.centerRight,
                                              // width:
                                              //     MediaQuery.of(context).size.width / 2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  16,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    controller.flyTypeText,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        height: 1.1,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackColor),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: blackColor,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }),
                                ),
                                //====== flynoteId  ==========
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GetBuilder<AllFlyNoteController>(
                                      init: AllFlyNoteController(),
                                      builder: (controller) {
                                        return GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) =>
                                                    controller.loading == true
                                                        ? const LoaderWidget()
                                                        : SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.5,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: controller
                                                                        .flyNote
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.onTapSelected(
                                                                              ctx,
                                                                              controller.flyNote[index].id);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 60,
                                                                              vertical: 15),
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 12,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                                                            child:
                                                                                Text(
                                                                              controller.flyNote[index].name,
                                                                              style: const TextStyle(color: primaryColor, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              alignment: Alignment.centerRight,
                                              // width:
                                              //     MediaQuery.of(context).size.width / 2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  16,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    controller.flyNoteText,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        height: 1.1,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackColor),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: blackColor,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }),
                                ),
                                //====== flySampleTypeId  ==========
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GetBuilder<AllFlySampleController>(
                                      init: AllFlySampleController(),
                                      builder: (controller) {
                                        return GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) =>
                                                    controller.loading == true
                                                        ? const LoaderWidget()
                                                        : SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2.5,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: controller
                                                                        .flySample
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.onTapSelected(
                                                                              ctx,
                                                                              controller.flySample[index].id);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 60,
                                                                              vertical: 15),
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 12,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.grey)),
                                                                            child:
                                                                                Text(
                                                                              controller.flySample[index].name,
                                                                              style: const TextStyle(color: primaryColor, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              alignment: Alignment.centerRight,
                                              // width:
                                              //     MediaQuery.of(context).size.width / 2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  16,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    controller.flySampleText,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        height: 1.1,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackColor),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: blackColor,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ));
                                      }),
                                ),

                                //<<<<<<<<<<<<<<<<<<Two Images >>>>>>>>>>>>>>>>>>>>>>>>>>>
                                //<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    imgCtrl.image != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: lightPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.file(
                                              imgCtrl.image!,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/question-mark.png',
                                                  width: 45,
                                                  height: 45,
                                                ),
                                                const Text(
                                                  'برجاء إرفاق صورة البلاغ الاولى ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'hanimation',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                    imgCtrl.image2 != null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: lightPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.file(
                                              imgCtrl.image2!,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/question-mark.png',
                                                  width: 45,
                                                  height: 45,
                                                ),
                                                const Text(
                                                  'برجاء إرفاق صورة البلاغ الثانية',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'hanimation',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Send Report button
                          GetBuilder<CurrentLocationController>(
                              init: CurrentLocationController(),
                              builder: (locationCtrl) {
                                return GetBuilder<AllCitiesController>(
                                    init: AllCitiesController(),
                                    builder: (cityCtrl) {
                                      return GetBuilder<AllDistrictController>(
                                          init: AllDistrictController(
                                              cityCtrl.cityId.value),
                                          builder: (disCtrl) {
                                            return GetBuilder<
                                                    AllFlyTypeController>(
                                                init: AllFlyTypeController(),
                                                builder: (flyType) {
                                                  return GetBuilder<
                                                          AllFlyNoteController>(
                                                      init:
                                                          AllFlyNoteController(),
                                                      builder: (flyNoteCtrl) {
                                                        return GetBuilder<
                                                                AllFlySampleController>(
                                                            init:
                                                                AllFlySampleController(),
                                                            builder:
                                                                (sampleCtrl) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  if (_reportFormKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    _reportFormKey
                                                                        .currentState!
                                                                        .save();

                                                                    log(TokenPref
                                                                        .getTokenValue());
                                                                    log("street : $street");
                                                                    log("cityCtrl.cityId.value : ${cityCtrl.cityId.value}");
                                                                    log("ph : $ph");
                                                                    log("recommendation : $recommendation");
                                                                    log("windspeed : $windspeed");
                                                                    log("temperature : $temperature");
                                                                    log("humidity : $humidity");
                                                                    log("waving : $waving");
                                                                    log("current Lat  : ${locationCtrl.currentLat}");
                                                                    log("current Long  : ${locationCtrl.currentLong}");
                                                                    log("city : ${cityCtrl.cityText}");
                                                                    log("district  : ${disCtrl.districtText}");
                                                                    log("flytype  : ${flyType.flyTypeText}");
                                                                    log("flyNote  : ${flyNoteCtrl.flyNoteText}");
                                                                    log("FLySample  : ${sampleCtrl.flySampleText}");
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      17,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40),
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
                                                                  child:
                                                                      const Text(
                                                                    "إرسال الإستكشاف ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      });
                                                });
                                          });
                                    });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
