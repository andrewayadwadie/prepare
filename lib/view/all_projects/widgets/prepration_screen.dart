import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/style.dart';
import '../../shared_widgets/header_widget.dart';
import '../../shared_widgets/line_dot.dart';
import '../model/prepare_model.dart';

class PrepartionScreen extends StatelessWidget {
  const PrepartionScreen({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;
  final ProjectModel data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderWidget(arrow: true),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontFamily: 'hanimation'),
                ),
              ),
              const LineDots(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width / 1.06,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Column(
                    children: [
                      //!Header
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text('التحضيرات ',
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text('الإجمالى ',
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                      //!Body
                      Expanded(
                          flex: 15,
                          child: Column(
                           children: [
                             Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child:   Text('Number Of Teams'.tr,
                                    style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: redColor,
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child:   const Text('${20}',
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        
                           ],
                          )),
                    ],
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
