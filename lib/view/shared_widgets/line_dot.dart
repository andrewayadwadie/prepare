import 'package:flutter/material.dart';

import '../../utils/style.dart';

class LineDots extends StatelessWidget {
  const LineDots({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                const Spacer(flex: 15,),
               
                 Container(
                   width: MediaQuery.of(context).size.width/15,
                  height: MediaQuery.of(context).size.height/120,
                  decoration: BoxDecoration(
                    color: lightPrimaryColor,
                    borderRadius: BorderRadius.circular(80)
                  ),
                ),
              const  Spacer(flex: 1,),
                Container(
                  width: MediaQuery.of(context).size.width/5,
                  height: MediaQuery.of(context).size.height/120,
                  decoration: BoxDecoration(
                    color: lightPrimaryColor,
                    borderRadius: BorderRadius.circular(80)
                  ),
                ),
                const Spacer(flex: 15,),
              ],
            );
  }
}