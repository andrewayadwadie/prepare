import 'package:get/get.dart';

class ToolsController extends GetxController {
  RxString toolsCount = "0".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  void gettoolsCount(String count) {
    toolsCount.value = count;
    update();
  }
}
