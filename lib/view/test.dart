import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/controller/click_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/shared_widgets/header_widget.dart';

class TestScreen extends StatelessWidget {
    TestScreen({ Key? key }) : super(key: key);
bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(arrow: true),

               SizedBox(
                 height:MediaQuery.of(context).size.height/10 ,
               ),
               GetBuilder<ClickController>(
                 init: ClickController(),
                 builder: (controller) {
                   return InkWell(
                     onTap: (){
                       if(controller.clicked == false){
                         Get.snackbar("hiii i clicked here", "hi iclicked");
                         controller.changeClick();
                       }

                     },
                     child: Container(
                       alignment: Alignment.center,
                       width: 230,
                       height: 60,
                       decoration: BoxDecoration(
                         color:controller.clicked == false ? primaryColor: Colors.grey,
                         borderRadius: BorderRadius.circular(20)
                       ),
                       child:const Text("test",style: TextStyle(color:Colors.white,fontSize: 25),)
                     ),
                   );
                 }
               )
            ],
          ),
        ) 
      ) ,
    );
  }
}