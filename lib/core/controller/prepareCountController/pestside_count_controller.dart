import 'package:get/get.dart';
import 'package:prepare/core/service/prepration_services.dart';

class PestSideCountController extends GetxController {
  List<dynamic> pestSide = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getPestSideCount();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getPestSideCount() {
    if (_loading.value == true) {
      PreprationServices.getAllPesides().then((value) {
        pestSide = value;
        _loading.value = false;
        update();
      });
    }
    return pestSide;
  }
}
