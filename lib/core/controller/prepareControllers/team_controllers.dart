import 'package:get/get.dart';

class TeamController extends GetxController {
  RxString teamCount = "0".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  void getteamCount(String count) {
    teamCount.value = count;
    update();
  }
}
