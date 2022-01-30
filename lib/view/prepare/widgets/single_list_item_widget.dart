import 'package:flutter/material.dart';

class SingleListItem extends StatelessWidget {
  const SingleListItem({Key? key,
 required  this.title, 
  required this.count}) : super(key: key);

final String title ;
final String count;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: MediaQuery.of(context).size.height / 15,
        decoration: BoxDecoration(
          color: const Color(0xff91C483),
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
                  color: Colors.white, fontFamily: "hanimation", fontSize: 16),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                  color: const Color(0xffF6D860),
                  borderRadius: BorderRadius.circular(50)),
              child:  Text(
                count,
                textAlign: TextAlign.center,
                style:const TextStyle(
                    color: Colors.white,
                    fontFamily: 'hanimation',
                    fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
