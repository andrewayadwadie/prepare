import 'package:get/get.dart';
import '../../service/prepration_services.dart';

class ToolsCountController extends GetxController {
  List<dynamic> tools = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getToolsCount();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getToolsCount() {
    if (_loading.value == true) {
      PreprationServices.getAllTools().then((value) {
        tools = value;
        _loading.value = false;
        update();
      });
    }
    return tools;
  }
}
