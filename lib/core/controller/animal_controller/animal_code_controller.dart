import 'package:get/get.dart';

import '../../service/animal_services.dart';

class AnimaCodeController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   getAnimalCode();
  // }

  RxString animalCode = "".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  dynamic getAnimalCode() {
    if (_loading.value == true) {
      AnimalServices.getAnimalCode().then((value) {
        animalCode.value = value;
        _loading.value = false;
        update();
      });
    }
    return animalCode;
  }
}
