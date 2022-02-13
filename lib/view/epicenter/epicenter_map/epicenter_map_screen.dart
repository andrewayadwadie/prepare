import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/epicenter/all_nearst_point_controllerd.dart';
import 'package:prepare/core/controller/map/google_map_controller.dart';
import 'package:prepare/core/controller/map/location_controller.dart';
import 'package:prepare/utils/style.dart';

class EpiCenterMapScreen extends StatelessWidget {
  const EpiCenterMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<MapCtrl>(
                init: MapCtrl(),
                builder: (mapCtrl) {
                  return GetBuilder<CurrentLocationController>(
                    init: CurrentLocationController(),
                    builder: (current) {
                      return GetBuilder<AllNearstPointsController>(
                        init: AllNearstPointsController(current.lat??0.0,current.long??0.0),
                        builder: (poinCtrl) {
                        
                          List<LatLng> locations = List.generate(poinCtrl.point.length, (index) {
                            return LatLng(double.parse(poinCtrl.point[index].lat),double.parse(poinCtrl.point[index].long));
                          });
                         mapCtrl.setMarkers(locations);
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              GoogleMap(
                                initialCameraPosition: mapCtrl.initialCamPos,
                                mapType: MapType.normal,
                                onTap: mapCtrl.setMarker,
                               markers:mapCtrl.marks! ,
                                onMapCreated: (GoogleMapController controller) {
                                  mapCtrl.compeleteController.complete(controller);
                                },
                                onCameraMove: (CameraPosition newPos) {
                                  mapCtrl.onCamMove(newPos.target);
                                },
                              ),

/*
                              /// set mark
                              mapCtrl.mark == null
                                  ? InkWell(
                                      onTap: () =>
                                          mapCtrl.setMarker(mapCtrl.currentLocation),
                                      child: const SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.location_on,
                                            color: redColor,
                                          )),
                                    )
                                  : const SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),

                              ///choose mark and pop
                              mapCtrl.mark != null
                                  ? GetBuilder<LocationCtrl>(
                                      init: LocationCtrl(),
                                      builder: (locationCtrl) {
                                        return Positioned(
                                          top: MediaQuery.of(context).size.height / 50,
                                          right:
                                              MediaQuery.of(context).size.width / 5.3,
                                          child: InkWell(
                                            onTap: () {
                                              locationCtrl.getSelectedLocation(
                                                  mapCtrl.currentLocation.latitude,
                                                  mapCtrl.currentLocation.longitude);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context).size.width /
                                                  1.5,
                                              height:
                                                  MediaQuery.of(context).size.height /
                                                      20,
                                              decoration: BoxDecoration(
                                                  color: lightPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: const Text(
                                                "إختار",
                                                style: TextStyle(color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : const SizedBox(
                                      width: 10,
                                      height: 10,
                                    )
                            
                            */
                            ],
                          );
                        }
                      );
                    }
                  );
                })),

        /// get my location
        floatingActionButton: GetBuilder<LocationCtrl>(
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
            }));
  }
}
