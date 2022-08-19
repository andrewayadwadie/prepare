import 'package:flutter/material.dart';
import '../../../utils/style.dart';

class InfoCardBodyItem extends StatelessWidget {
  const InfoCardBodyItem({
    Key? key,
    required this.title,
    required this.number, required this.controller,
  }) : super(key: key);

  final String title;
  final String number;
  final TextEditingController controller ;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: h3Style,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )),
            Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 30,
                  // color: Colors.green,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 2, right: 15, left: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 35,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(number,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                )),
          ],
        ));
  }
}
