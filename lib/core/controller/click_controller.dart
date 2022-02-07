import 'package:get/get.dart';

class ClickController extends GetxController{
  bool clicked = false;

  void changeClick(){
    clicked = !clicked;
    update();
  }
}