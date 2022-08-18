import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/controller/bug_dicover/bug_discover_map_controller.dart';
import '../../../core/controller/bug_dicover/nearst_visit_controller.dart';
import '../../../core/controller/current_location_controller.dart';

// ignore: must_be_immutable
class BugDIscoverMapScreen extends StatelessWidget {
  BugDIscoverMapScreen({Key? key}) : super(key: key);

  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());

  @override
  Widget build(BuildContext context) {
    NearstBugDiscoverVisit pointController = Get.put(
        NearstBugDiscoverVisit(currentLocation.lat ?? 0.0,
            currentLocation.lat ?? 0.0));

    return Scaffold(
        body: SafeArea(
            child: GetBuilder<BugDiscoverMapCtrl>(
                init: BugDiscoverMapCtrl(),
                builder: (mapCtrl) {
                  List<LatLng> locations =
                      List.generate(pointController.point.length, (index) {
                    return LatLng(
                        double.parse(pointController.point[index].lat),
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
                        myLocationButtonEnabled: true,
                        indoorViewEnabled: true,
                        // trafficEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          mapCtrl.compeleteController.complete(controller);
                          // mapCtrl.setMarkers(locations);
                        },
                        onCameraMove: (CameraPosition newPos) {
                          mapCtrl.onCamMove(newPos.target);
                          mapCtrl.setMarkers(locations);
                        },
                      ),
                    ],
                  );
                })),

        /// get my location
       /*
        floatingActionButton: GetBuilder<LocationCtrl>(
            init: LocationCtrl(),
            builder: (locatioController) {
              return GetBuilder<BugDiscoverMapCtrl>(
                  init: BugDiscoverMapCtrl(),
                  builder: (mapCtrll) {
                    return FloatingActionButton(
                      onPressed: () async {
                        LocationData _myLocation =
                            await locatioController.getLocation();
                        mapCtrll.animateCamera(_myLocation);
                        mapCtrll.setMarker(mapCtrll.currentLocation);
                      },
                      child: const Icon(Icons.gps_fixed),
                    );
                  });
            })
            */
            );
  }
}
