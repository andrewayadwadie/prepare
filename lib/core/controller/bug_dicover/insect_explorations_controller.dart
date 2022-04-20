import 'package:get/get.dart';

import '../../service/bug_discover_services.dart';

class GetAllInsectExplorationsController extends GetxController {
  GetAllInsectExplorationsController(this.id);
  final int id;
  List<dynamic> insectExplorations = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getInsectExplorationsCount(id);
    super.onInit();
  }

  bool get loading => _loading.value;
  dynamic getInsectExplorationsCount(int id) {
    if (_loading.value == true) {
      BugDiscoverServices.getInsectExploration(id).then((value) {
        insectExplorations = value;
        _loading.value = false;
        update();
      });
    }
    return insectExplorations;
  }
}
