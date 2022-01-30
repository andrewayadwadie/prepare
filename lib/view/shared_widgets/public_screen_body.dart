import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prepare/utils/style.dart';
import 'header_widget.dart';
import 'line_dot.dart';

class PublicScreenBody extends StatelessWidget {
  const PublicScreenBody(
      {Key? key, required this.singleScreen, required this.title})
      : super(key: key);
  final Widget singleScreen;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              const HeaderWidget(arrow: true,),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Text(
                title.tr,
                style: const TextStyle(fontSize: 25, fontFamily: 'hanimation',color: primaryColor),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
              ),
              const LineDots(),
              SizedBox(height: MediaQuery.of(context).size.height/55,),
              SizedBox(
              //  color: Colors.yellow.withOpacity(0.2),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 1.59,
                  //  color: secondaryColor,
                  child: SingleChildScrollView(
                 // reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child:
                       singleScreen
                  
                  )),
              // const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
