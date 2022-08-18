import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/controller/current_location_controller.dart';
import '../../../core/controller/epicenter/all_nearst_point_controllerd.dart';
import '../../../core/controller/map/google_map_controller.dart';

// ignore: must_be_immutable
class EpiCenterMapScreen extends StatelessWidget {
  EpiCenterMapScreen({Key? key}) : super(key: key);

  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());

  @override
  Widget build(BuildContext context) {
    AllNearstPointsController pointController = Get.put(
        AllNearstPointsController(
            currentLocation.lat ?? 0.0, currentLocation.lat ?? 0.0));

    return Scaffold(
      body: SafeArea(
          child: GetBuilder<MapCtrl>(
              init: MapCtrl(),
              builder: (mapCtrl) {
                List<LatLng> locations =
                    List.generate(pointController.point.length, (index) {
                  return LatLng(double.parse(pointController.point[index].lat),
                      double.parse(pointController.point[index].long));
                });

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      initialCameraPosition: mapCtrl.initialCamPos,
                      mapType: MapType.normal,
                      onTap: mapCtrl.setMarker,
                      markers: mapCtrl.marks,
                      polylines: mapCtrl.polyline,
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        mapCtrl.compeleteController.complete(controller);
                      },
                      onCameraMove: (CameraPosition newPos) {
                        mapCtrl.onCamMove(newPos.target);
                        mapCtrl.setMarkers(locations);
                      },
                    ),
                  ],
                );
              })),
    );
  }
}
