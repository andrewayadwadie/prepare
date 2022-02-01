import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/intro/intro.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(arrow: false),
              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 2.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/nointernet.png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              InkWell(
                onTap: () {
                  Get.offAll(const IntroPage());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: BoxDecoration(
                      color: lightPrimaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "محاولة مرة أخري ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
