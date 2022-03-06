import 'package:flutter/material.dart';

import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/mapbox/controller/mapbox_controller.dart';

class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({Key? key}) : super(key: key);

  @override
  _MapBoxScreenState createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<MapBoxController>(
              init: MapBoxController(),
              builder: (box) {
                return InkWell(
                  onTap: () async {
                    var wayPoints = <WayPoint>[];
                    // wayPoints.add(origin);
                    wayPoints.add(box.stop0);
                    wayPoints.add(box.stop1);
                    wayPoints.add(box.stop2);
                    wayPoints.add(box.stop3);
                    wayPoints.add(box.stop5);
                    wayPoints.add(box.stop6);
                    wayPoints.add(box.stop7);
                    wayPoints.add(box.stop8);
                    wayPoints.add(box.stop9);
                    wayPoints.add(box.stop10);
                    wayPoints.add(box.stop11);
                    wayPoints.add(box.stop12);
                    wayPoints.add(box.stop13);
                    wayPoints.add(box.stop14);
                    wayPoints.add(box.stop15);
                    wayPoints.add(box.stop16);
                    wayPoints.add(box.stop17);
                    wayPoints.add(box.stop18);
                    wayPoints.add(box.stop19);
                    wayPoints.add(box.stop20);
                    wayPoints.add(box.stop21);
                    wayPoints.add(box.stop22);
                    wayPoints.add(box.stop23);
                    wayPoints.add(box.stop24);
                    wayPoints.add(box.stop25);
                    wayPoints.add(box.stop26);
                    wayPoints.add(box.stop27);
                    wayPoints.add(box.stop28);
                    wayPoints.add(box.stop29);
                    wayPoints.add(box.stop30);

                    await box.directions.startNavigation(
                        wayPoints: wayPoints,
                        options: MapBoxOptions(
                            mode: MapBoxNavigationMode.drivingWithTraffic,
                            simulateRoute: false,
                            language: "en",
                            units: VoiceUnits.metric));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 350, horizontal: 80),
                    child: Container(
                      alignment: Alignment.center,
                      width: 230,
                      height: 90,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "إبدأ الرحلة  ",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
