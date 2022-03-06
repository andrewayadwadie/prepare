import 'package:get/get.dart';
import 'package:location/location.dart';

class CurrentLocationController extends GetxController {
  @override
  void onInit() {
    getLocationByLocation();
    super.onInit();
  }
 
  final Location location = Location();

  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;

  double? lat;
  double? long;

  get currentLat => lat;

  get currentLong => long;
  getLocationByLocation() async {
    if (permissionGranted == null || locationData == null) {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      location.getLocation().then((currentLocation){
        lat = currentLocation.latitude;
        long = currentLocation.longitude;
        update();
      });
        
        // Use current location
      
     
    }
  }
}
