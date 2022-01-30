
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:prepare/utils/style.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
        colors:const  [lightPrimaryColor,lightPrimaryColor,lightPrimaryColor,lightPrimaryColor,primaryColor],       /// Optional, The color collections
        strokeWidth: 1, 
                          /// Optional, The stroke of the line, only applicable to widget which contains line
        backgroundColor: Colors.white.withOpacity(0.1),      /// Optional, Background of the widget
        pathBackgroundColor: Colors.white.withOpacity(0.1)   /// Optional, the stroke backgroundColor
      ),
      ),
    );
  }
}