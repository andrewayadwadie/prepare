import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_map_controller.dart';
import 'package:prepare/core/controller/epicenter/all_nearst_point_controllerd.dart';
import 'package:prepare/core/controller/map/google_map_controller.dart';
import 'package:prepare/core/controller/map/location_controller.dart';
import 'package:google_directions_api/google_directions_api.dart';

// ignore: must_be_immutable
class DailyWorkScreen extends StatefulWidget {
  const DailyWorkScreen({Key? key}) : super(key: key);

  @override
  State<DailyWorkScreen> createState() => _DailyWorkScreenState();
}

class _DailyWorkScreenState extends State<DailyWorkScreen> {
  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());

  @override
  Widget build(BuildContext context) {
    // AllNearstPointsController pointController = Get.put(
    //     AllNearstPointsController(currentLocation.currentLat ?? 0.0,
    //         currentLocation.currentLat ?? 0.0));

    return Scaffold(
        body: SafeArea(
            child: GetBuilder<DailyWorkMapCtrl>(
                init: DailyWorkMapCtrl(),
                builder: (mapCtrl) {
                  // List<LatLng> locations =
                  //     List.generate(pointController.point.length, (index) {
                  //   return LatLng(
                  //       double.parse(pointController.point[index].lat),
                  //       double.parse(pointController.point[index].long));
                  // });

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        initialCameraPosition: mapCtrl.initialCamPos,
                        mapType: MapType.normal,
                        //   onTap: mapCtrl.setMarker,
                        markers: <Marker>{mapCtrl.currentMark},
                        polylines: mapCtrl.allPolyLine,
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          mapCtrl.compeleteController.complete(controller);
                        },
                        onCameraMove: (CameraPosition newPos) {
                          //    mapCtrl.onCamMove(newPos.target);
                        //   mapCtrl.setCurrentPath();
                      //    mapCtrl.setOriginPath();
                       mapCtrl.  setCurrentPath();
                        },
                      ),
                    ],
                  );
                })),

        /// get my location
      /*  floatingActionButton: GetBuilder<LocationCtrl>(
            init: LocationCtrl(),
            builder: (locatioController) {
              return GetBuilder<MapCtrl>(
                  init: MapCtrl(),
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
/*


  DirectionsService.init(
      'AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4');

  final directinosService = DirectionsService();

  DirectionsRequest request = const DirectionsRequest(
    origin: "30.081654223476963, 31.35709440794601",
    destination:
        "30.121661245415556, 31.14124346609501",
    travelMode: TravelMode.driving,
  );

  directinosService.route(request, (response, status) {
    if (status == DirectionsStatus.ok) {
      log("Status  = $status");
      log("routes  = ${response.routes!.length}");
    } else {
      log("Status  = $status");
      log("error message  = ${response.routes!.length}");
    }
  });




 */