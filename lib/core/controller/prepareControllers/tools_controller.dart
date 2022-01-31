import 'package:get/get.dart';

class ToolsController extends GetxController {
  List toolsCount = [];

  void gettoolsCount(int count) {
    toolsCount.add(count);
    update();
  }

  int getToolsSum(List toolsList) {
    int sum = 0;
    for (int i = 0; i < toolsList.length; i++) {
      sum += toolsList[i] as int;
    }

    return sum;
  }
}
