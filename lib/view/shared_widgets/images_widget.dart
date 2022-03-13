import 'dart:io';

import 'package:flutter/material.dart';

import 'package:prepare/utils/style.dart';
import 'package:get/get.dart';
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
                height: MediaQuery.of(context).size.height / 7.5,
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
                height: MediaQuery.of(context).size.height /7.5,
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
                     Text(
                      'please attach a first photo of exploration'.tr,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                        height: 1.1,
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
                height: MediaQuery.of(context).size.height / 7.5,
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
                height: MediaQuery.of(context).size.height / 7.5,
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
                     Text(
                      'please attach a second photo of exploration'.tr,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          color: Colors.white,
                          height: 1.1,
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
