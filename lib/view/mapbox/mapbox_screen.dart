import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:prepare/utils/style.dart';

class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({Key? key}) : super(key: key);

  @override
  _MapBoxScreenState createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  String platformVersion = 'Unknown';
  String instruction = "";
  final origin = WayPoint(
      name: "Way Point 1",
      latitude: 30.08618747574932,
      longitude: 31.341274503626887);

  final stop0 = WayPoint(
    name: "Way Point 0",
    latitude: 30.086229335462193,
    longitude: 31.341038380691675,
  );
  final stop1 = WayPoint(
    name: "Way Point 1",
    latitude: 30.086767530497323,
    longitude: 31.34112449621265,
  );
  final stop2 = WayPoint(
    name: "Way Point 2",
    latitude: 30.086731654596115,
    longitude: 31.34184537608262,
  );
  final stop3 = WayPoint(
    name: "Way Point 3",
    latitude: 30.086706815015418,
    longitude: 31.341902791302488,
  );
  final stop4 = WayPoint(
    name: "Way Point 4",
    latitude: 30.086753734747173,
    longitude: 31.342550305912365,
  );
  final stop5 = WayPoint(
    name: "Way Point 5",
    latitude: 30.08598094404892,
    longitude: 31.342425905308726,
  );
  final stop6 = WayPoint(
    name: "Way Point 6",
    latitude: 30.085569709102625,
    longitude: 31.34236530065995,
  );
  final stop7 = WayPoint(
    name: "Way Point 7",
    latitude: 30.08549518997967,
    longitude: 31.34235573154247,
  );
  final stop8 = WayPoint(
    name: "Way Point 8",
    latitude: 30.086124454248406,
    longitude: 31.343762394647335,
  );
  final stop9 = WayPoint(
    name: "Way Point 9",
    latitude: 30.086419777602295,
    longitude: 31.34453110980839,
  );
  final stop10 = WayPoint(
    name: "Way Point 10",
    latitude: 30.086541214500215,
    longitude: 31.344888358647147,
  );
  final stop11 = WayPoint(
    name: "Way Point 11",
    latitude: 30.086557774384204,
    longitude: 31.344869220468116,
  );
  final stop12 = WayPoint(
    name: "Way Point 12",
    latitude: 30.086201737746464,
    longitude: 31.345089307572916,
  );
  final stop13 = WayPoint(
    name: "Way Point 13",
    latitude: 30.08597542153902,
    longitude: 31.344977665842006,
  );
  final stop14 = WayPoint(
    name: "Way Point 14",
    latitude: 30.08591194328565,
    longitude: 31.344830939200296,
  );
  final stop15 = WayPoint(
    name: "Way Point 15",
    latitude: 30.085848464785492,
    longitude: 31.344875597692354,
  );
  final stop16 = WayPoint(
    name: "Way Point 16",
    latitude: 30.0854041074046,
    longitude: 31.34510525349171,
  );
  final stop17 = WayPoint(
      name: "Way Point 17",
      latitude: 30.084827271927534,
      longitude: 31.343807048245267);
  final stop18 = WayPoint(
    name: "Way Point 18",
    latitude: 30.084814732544363,
    longitude: 31.343716303373224,
  );
  final stop19 = WayPoint(
    name: "Way Point 19",
    latitude: 30.085310711834047,
    longitude: 31.343452890056426,
  );
  final stop20 = WayPoint(
    name: "Way Point 20",
    latitude: 30.085346012595824,
    longitude: 31.34350702259599,
  );
  final stop21 = WayPoint(
    name: "Way Point 21",
    latitude: 30.085739064178462,
    longitude: 31.344375261038653,
  );
  final stop22 = WayPoint(
    name: "Way Point 22",
    latitude: 30.085918091766754,
    longitude: 31.344831772194812,
  );
  final stop23 = WayPoint(
    name: "Way Point 23",
    latitude: 30.086144657863944,
    longitude: 31.344666039160806,
  );
  final stop24 = WayPoint(
    name: "Way Point 24",
    latitude: 30.086428077797052,
    longitude: 31.34453629434621,
  );
  final stop25 = WayPoint(
    name: "Way Point 25",
    latitude: 30.086161908176962,
    longitude: 31.343828037318573,
  );
  final stop26 = WayPoint(
    name: "Way Point 26",
    latitude: 30.08581224329338,
    longitude: 31.343050613619493,
  );
  final stop27 = WayPoint(
    name: "Way Point 27",
    latitude: 30.085508548470163,
    longitude: 31.342372881802905,
  );
  final stop28 = WayPoint(
    name: "Way Point 28",
    latitude: 30.085490305298013,
    longitude: 31.342139582159934,
  );
  final stop29 = WayPoint(
    name: "Way Point 29",
    latitude: 30.08552470213527,
    longitude: 31.341720696756923,
  );
  final stop30 = WayPoint(
      name: "Way Point 30",
      latitude: 30.08558808515157,
      longitude: 31.3409405640069);

  MapBoxNavigation? directions;
  MapBoxOptions? options;

  final bool isMultipleStop = false;
  double? distanceRemaining, durationRemaining;
  MapBoxNavigationViewController? controller;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {

    if (!mounted) return;

    directions = MapBoxNavigation(onRouteEvent: onEmbeddedRouteEvent);
    options = MapBoxOptions(
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await directions!.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () async {
              var wayPoints = <WayPoint>[];
              // wayPoints.add(origin);
              wayPoints.add(stop0);
              wayPoints.add(stop1);
              wayPoints.add(stop2);
              wayPoints.add(stop3);
              wayPoints.add(stop5);
              wayPoints.add(stop6);
              wayPoints.add(stop7);
              wayPoints.add(stop8);
              wayPoints.add(stop9);
              wayPoints.add(stop10);
              wayPoints.add(stop11);
              wayPoints.add(stop12);
              wayPoints.add(stop13);
              wayPoints.add(stop14);
              wayPoints.add(stop15);
              wayPoints.add(stop16);
              wayPoints.add(stop17);
              wayPoints.add(stop18);
              wayPoints.add(stop19);
              wayPoints.add(stop20);
              wayPoints.add(stop21);
              wayPoints.add(stop22);
              wayPoints.add(stop23);
              wayPoints.add(stop24);
              wayPoints.add(stop25);
              wayPoints.add(stop26);
              wayPoints.add(stop27);
              wayPoints.add(stop28);
              wayPoints.add(stop29);
              wayPoints.add(stop30);

              await directions!.startNavigation(
                  wayPoints: wayPoints,
                  options: MapBoxOptions(
                      mode: MapBoxNavigationMode.drivingWithTraffic,
                      simulateRoute: false,
                      language: "en",
                      units: VoiceUnits.metric));
          
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 350,horizontal: 80),
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
          ),
        ),
      ),
    );
  }

  Future<void> onEmbeddedRouteEvent(e) async {
    distanceRemaining = await directions!.distanceRemaining;
    durationRemaining = await directions!.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await controller!.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          routeBuilt = false;
          isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
