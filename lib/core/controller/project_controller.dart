import 'package:get/get.dart';

import '../../view/all_projects/model/prepare_model.dart';
import '../service/project_services.dart';

class ProjectController extends GetxController {
  List<ProjectModel> projects = [];
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getAllProjectsData();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<ProjectModel> getAllProjectsData() {
    if (_loading.value == true) {
      ProjectServices.getAllProjects().then((value) {
        if (value.runtimeType == List<ProjectModel>) {
          projects = value;
          _loading.value = false;
          update();
        } else {
          projects = [];
          _loading.value = false;
        }
      });
    }
    return projects;
  }
}
