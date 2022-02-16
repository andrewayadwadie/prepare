import 'dart:io';

import 'package:flutter/material.dart';

import 'package:prepare/utils/style.dart';

class ImagesWidget extends StatelessWidget {
  const ImagesWidget({
    Key? key,
    required this.path1,
    required this.path2,
    required this.file1,
    required this.file2,
  }) : super(key: key);
  final String path1;
  final String path2;
  final File file1;
  final File file2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        path1 != ""
            ? Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 10,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: lightPrimaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.file(
                  file1,
                  width: 120,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
        path2 != ""
            ? Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 10,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: lightPrimaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.file(
                  file2,
                  width: 120,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
