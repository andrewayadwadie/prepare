import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.arrow}) : super(key: key);
  final bool arrow;
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          gradient: LinearGradient(
              colors: [
                lightPrimaryColor,
                primaryColor,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height / 16,
        right: MediaQuery.of(context).size.width / 2.63,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(60),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/logo.png",
                  ),
                  fit: BoxFit.contain,
                )),
          ),
        ),
      ),
      if (arrow == true)
        Positioned(
          top: 18,
          left: 18,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
           //   decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.red)),
              width: MediaQuery.of(context).size.width / 7,
              height: MediaQuery.of(context).size.height / 15,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
    ]);
  }
}
