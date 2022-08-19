import 'package:get/get.dart';
import '../../service/bug_discover_services.dart';

class BugDiscoverCodeController extends GetxController {
  RxString bugDiscoverCode = "".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  dynamic getBugDiscoverCodeCount( int cityId,int flyTypeId,) {
    if (_loading.value == true) {
      BugDiscoverServices.getBugDiscoverCode(cityId, flyTypeId).then((value) {
        bugDiscoverCode.value = value;
        _loading.value = false;
        update();
      });
    }
    return bugDiscoverCode;
  }
}