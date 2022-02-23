import 'package:get/get.dart';

class Evaluate extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   evaluateList.length = evaluateList.length + 1;
  // }

  List evaluateList = [].obs;

  void increaseList( ) {
    evaluateList.length=evaluateList.length+1;
    update();
  }
  void decreaseList( ) {
    evaluateList.length=evaluateList.length-1;
    update();
  }
}
