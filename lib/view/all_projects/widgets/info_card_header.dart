import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/style.dart';

class InfoCardHeader extends StatelessWidget {
  const InfoCardHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Get.locale == const Locale("en")
          ? Alignment.centerLeft
          : Alignment.centerRight,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Text(
        title,
        style: blackTextStyle,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }
}
