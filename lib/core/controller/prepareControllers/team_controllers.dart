import 'package:get/get.dart';

class TeamController extends GetxController {
  List teamCount = [];

  List<Map<String, dynamic>> teamObjectList = [];

  void getteamCount(int count) {
    teamCount.add(count);
    update();
  }

  void addTeamObject(int id, int count) {
    teamObjectList.add({"TeamId": id, "NumberOfEmployees": count});
    update();
  }

  int getTeameSum(List teamList) {
    int sum = 0;
    for (int i = 0; i < teamList.length; i++) {
      sum += teamList[i] as int;
    }
    return sum;
  }
}



/*


class TeamControldler extends GetxController {
  RxString teamCount = "0".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  void getteamCount(String count) {
    teamCount.value = count;
    update();
  }
}



 */