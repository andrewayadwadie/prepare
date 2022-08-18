import 'package:get/get.dart';

import '../../service/epicenter_services.dart';

class InsectCodeController extends GetxController {
  RxString insectCode ="".obs;
  final RxBool _loading = true.obs;

// final int isectId;

//   InsectCodeController(this.isectId);
//   @override
//   void onInit() {
//     getInsectCodeCount(isectId);
//     super.onInit();
//   }

  bool get loading => _loading.value;
  dynamic getInsectCodeCount( int insectId) {
    if (_loading.value == true) {
      EpicenterServices.getInsectsCode( insectId).then((value) {
        insectCode.value = value;
        _loading.value = false;
        update();
      });
    }
    return insectCode;
  }
}
