import '../service/project_services.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  List<dynamic> projects = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getAllProjectsData();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getAllProjectsData() {
    if (_loading.value == true) {
      ProjectServices.getAllProjects().then((value) {
        projects = value;
        _loading.value = false;
        update();
      });
    }
    return projects;
  }
}
