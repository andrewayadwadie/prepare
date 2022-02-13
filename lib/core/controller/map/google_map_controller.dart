import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapCtrl extends GetxController {
    
 
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(30.0862704, 31.3415012),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> compeleteController = Completer();
  LatLng currentLocation = initialCameraPosition.target;
  //BitmapDescriptor? _locationIcon;

  Marker? mark;
  Set<Marker>? marks;

  get initialCamPos => initialCameraPosition;
//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  Future<void> animateCamera(LocationData _location) async {
    final GoogleMapController controller = await compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 16.4746);

    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPostion));
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>//

  void setMarker(LatLng _location) {
    Marker newMarker = Marker(
        markerId: MarkerId(_location.toString()),
        icon: BitmapDescriptor.defaultMarker,
        // icon: _locationIcon,
        position: _location,
        infoWindow: InfoWindow(
            title: "Info",
            snippet:
                "${currentLocation.latitude}, ${currentLocation.longitude}"),
        onTap: () {});

    mark = newMarker;
    update();
  }

//<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  void setMarkers(List<LatLng> locations) {
    for (var i = 0; i < locations.length; i++) {
      marks!.add(Marker(
          markerId: MarkerId(locations[i].toString()),
          icon: BitmapDescriptor.defaultMarker,
          // icon: locations[index]Icon,
          position: locations[i],
          infoWindow: InfoWindow(
              title: "Info",
              snippet:
                  "${currentLocation.latitude}, ${currentLocation.longitude}"),
          onTap: () {}));
      update();
    }
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  void onCamMove(LatLng newPos) {
    currentLocation = newPos;
    update();
  }
}
