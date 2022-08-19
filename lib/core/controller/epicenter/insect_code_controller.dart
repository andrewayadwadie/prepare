import 'package:get/get.dart';
import '../../service/epicenter_services.dart';

class InsectCodeController extends GetxController {
  RxString insectCode ="".obs;
  final RxBool _loading = true.obs;

  // @override
  // void onInit() {
  //   getInsectCodeCount();
  //   super.onInit();
  // }

  bool get loading => _loading.value;
  dynamic getInsectCodeCount(int cityId,int insectId) {
    if (_loading.value == true) {
      EpicenterServices.getInsectsCode(cityId,insectId).then((value) {
        insectCode.value = value;
        _loading.value = false;
        update();
      });
    }
    return insectCode;
  }
}