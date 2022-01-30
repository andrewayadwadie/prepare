import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/widgets/single_list_item_widget.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

// ignore: must_be_immutable
class PrepareScreen extends StatelessWidget {
    PrepareScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  final int id;
  final String title;
final _formKey = GlobalKey<FormState>();
  String? cars ;
  String? tools ;
  String? machines ;
  String? pesticides ;
  String? teams ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.031,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderWidget(arrow: true),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontFamily: 'hanimation'),
                ),
                const LineDots(),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height / 1.47,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: ListView(
                    children: [
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "إدخل عدد السيارات",
                                              style: TextStyle(
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
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40,
                                                          right: 40,
                                                          top: 40),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color:
                                                                      primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        labelText:
                                                            "عدد السيارات",
                                                        hintText:
                                                            "عدد السيارات",
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                        //enabledBorder: InputBorder.none
                                                        ),
                                                    onSaved: (val) {
                                                      cars = val;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'برجاء إدخال عدد السيارات';
                                                      } else {
                                                        return null;
                                                      }
                                                    }, // enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 30),
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            lightPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "تحضير ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'hanimation',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign:
                                                          TextAlign.center,
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
                                });
                          },
                          child:
                              SingleListItem(title: "السيارات", count: "10")),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "إدخل عدد الادوات",
                                              style: TextStyle(
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
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40,
                                                          right: 40,
                                                          top: 40),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color:
                                                                      primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        labelText:
                                                            "عدد الادوات",
                                                        hintText:
                                                            "عدد الادوات",
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                        //enabledBorder: InputBorder.none
                                                        ),
                                                    onSaved: (val) {
                                                      tools = val;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'برجاء إدخال عدد الادوات';
                                                      } else {
                                                        return null;
                                                      }
                                                    }, // enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 30),
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            lightPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "تحضير ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'hanimation',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign:
                                                          TextAlign.center,
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
                                });
                          },
                          child:
                              SingleListItem(title: "الاداوات", count: "2000")),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "إدخل عدد الاجهزة",
                                              style: TextStyle(
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
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40,
                                                          right: 40,
                                                          top: 40),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color:
                                                                      primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        labelText:
                                                            "عدد الأجهزة",
                                                        hintText:
                                                            "عدد الأجهزة",
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                        //enabledBorder: InputBorder.none
                                                        ),
                                                    onSaved: (val) {
                                                      machines = val;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'برجاء إدخال عدد الأجهزة';
                                                      } else {
                                                        return null;
                                                      }
                                                    }, // enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 30),
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            lightPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "تحضير ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'hanimation',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign:
                                                          TextAlign.center,
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
                                });
                          },
                          child:
                              SingleListItem(title: "الاجهزة ", count: "150")),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "إدخل عدد المبيدات",
                                              style: TextStyle(
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
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40,
                                                          right: 40,
                                                          top: 40),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color:
                                                                      primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        labelText:
                                                            "عدد المبيدات",
                                                        hintText:
                                                            "عدد المبيدات",
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                        //enabledBorder: InputBorder.none
                                                        ),
                                                    onSaved: (val) {
                                                      pesticides = val;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'برجاء إدخال عدد المبيدات';
                                                      } else {
                                                        return null;
                                                      }
                                                    }, // enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 30),
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            lightPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "تحضير ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'hanimation',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign:
                                                          TextAlign.center,
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
                                });
                          },
                          child:
                              SingleListItem(title: "المبيدات", count: "60")),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          const Center(
                                            child: Text(
                                              "إدخل عدد الفرق",
                                              style: TextStyle(
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
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 40,
                                                          right: 40,
                                                          top: 40),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: primaryColor,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 2,
                                                                  color:
                                                                      primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        labelText:
                                                            "عدد الفرق",
                                                        hintText:
                                                            "عدد الفرق",
                                                        labelStyle:
                                                            const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)
                                                        //enabledBorder: InputBorder.none
                                                        ),
                                                    onSaved: (val) {
                                                      teams = val;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'برجاء إدخال عدد الفرق';
                                                      } else {
                                                        return null;
                                                      }
                                                    }, // enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 30),
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            lightPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "تحضير ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'hanimation',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      textAlign:
                                                          TextAlign.center,
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
                                });
                          },
                          child: SingleListItem(title: "الفرق", count: "6")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
