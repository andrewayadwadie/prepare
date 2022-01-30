import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.2,
      child: Image.asset("assets/images/empty_product_banner.c076afe7.png",
      fit: BoxFit.contain,
      ),
    );
  }
}