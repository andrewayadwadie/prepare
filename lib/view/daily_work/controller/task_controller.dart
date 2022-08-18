import 'package:get/get.dart';

import '../service/task_service.dart';

 

class TaskController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gettasks();
  }
  RxString noData = "".obs;
  List  tasks = [];

  RxBool loading = true.obs;

  List  gettasks() {
    TaskService.getTasks().then((value) {
      if (value.runtimeType == List ) {
        tasks = value;
        loading.value = false;
        update();
      }else{
        noData.value = "No Data";
        loading.value = false;
        update();
      }
    });
    return tasks;
  }
}
