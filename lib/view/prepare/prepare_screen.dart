import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/prepare/widgets/single_list_item_widget.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';
import 'package:prepare/view/shared_widgets/line_dot.dart';

class PrepareScreen extends StatelessWidget {
  const PrepareScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  final int id;
  final String title;

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
                      const SingleListItem(title: "السيارات", count: "10"),
                      const SingleListItem(title: "الاداوات", count: "2000"),
                      const SingleListItem(title: "الاجهزة ", count: "150"),
                      const SingleListItem(title: "المبيدات", count: "60"),
                      const SingleListItem(title: "الفرق", count: "6"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      InkWell(
                        onTap: (){},
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
