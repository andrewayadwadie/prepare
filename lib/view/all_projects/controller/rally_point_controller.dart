import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../core/controller/map/location_controller.dart';

class RallyPointController extends GetxController {
  final double lat;
  final double long;
  LocationCtrl currentLocation = Get.put(LocationCtrl());
  bool isCorrectPoint = true;
  RallyPointController(this.lat, this.long);

  @override
  void onInit() {
    super.onInit();

    isInPoint(lat, long, currentLocation.locationLat, currentLocation.locationLng);

  }

  double calculateDistance(double lat1, double long1, double lat2, double long2) {
    var d1 = lat1 * (math.pi / 180.0);
    var num1 = long1 * (math.pi / 180.0);
    var d2 = lat2 * (math.pi / 180.0);
    var num2 = long2 * (math.pi / 180.0) - num1;
    var d3 = math.pow(math.sin((d2 - d1) / 2.0), 2.0) +
        math.cos(d1) * math.cos(d2) * math.pow(math.sin(num2 / 2.0), 2.0);
    return 6376500.0 * (2.0 * math.atan2(math.sqrt(d3), math.sqrt(1.0 - d3)));
  }

  void isInPoint(double lat1, double long1, double lat2, double long2) {
    if (lat1 == 0.0 && long1 == 0.0) {
      isCorrectPoint = true;
    } else if (calculateDistance(lat1, long1, lat2, long2) > 100) {
      isCorrectPoint = false;
    } else {
      isCorrectPoint = true;
    }
  }

  
}
