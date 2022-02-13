import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationCtrl extends GetxController {
  double _lat = 0.0;
  double _lng = 0.0;

  get locationLat => _lat;
  get locationLng => _lng;

  Future<LocationData> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception();
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  void getSelectedLocation(double latitute, double langtute) {
    _lat = latitute;
    _lng = langtute;

    update();
  }
}
