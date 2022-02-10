
import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';

// ignore: must_be_immutable
class SingleListItem extends StatelessWidget {
  SingleListItem({Key? key, required this.title, required this.count})
      : super(key: key);

  final String title;
  final String count;
  String? value;
 // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        color: offwhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                color:lightPrimaryColor, fontFamily: "hanimation", fontSize: 16),
          ),
          Container(
            alignment: Alignment.center,
            width: 45,
            height:45,
            decoration: BoxDecoration(
                color: yellowColor,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color:lightPrimaryColor,
                  fontFamily: 'hanimation',
                  fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
