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
  String _platformVersion = 'Unknown';
  String _instruction = "";
  final _origin = WayPoint(
      name: "Way Point 1",
      latitude: 30.035618911547267,
      longitude: 31.26636113963417);
  final _stop1 = WayPoint(
      name: "Way Point 2",
      latitude:30.024472115529424, 
      longitude: 31.25717897089643,);
  final _stop2 = WayPoint(
      name: "Way Point 3",
      latitude: 30.02157370508331,
      longitude:  31.254261507201033);
  final _stop3 = WayPoint(
      name: "Way Point 4",
      latitude: 30.02179727707968,
      longitude: 31.2587241890237);
  final _stop4 = WayPoint(
      name: "Way Point 5",
      latitude: 30.024918473017483,
      longitude: 31.261470078790833);

  MapBoxNavigation? _directions;
  MapBoxOptions? _options;

  final bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController? _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
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
      platformVersion = await _directions!.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        // appBar: AppBar(
        //   title: const Text('Plugin example app'),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               InkWell(
                 onTap: () async {
                    var wayPoints = <WayPoint>[];
                    wayPoints.add(_origin);
                    wayPoints.add(_stop1);

                    await _directions!.startNavigation(
                        wayPoints: wayPoints,
                        options: MapBoxOptions(
                            mode:
                                MapBoxNavigationMode.drivingWithTraffic,
                            simulateRoute: false,
                            language: "en",
                            units: VoiceUnits.metric));
                  },
                 child: Container(
                   alignment: Alignment.center,
                   width: 230,
                   height: 90,
                   decoration: BoxDecoration(
                     color: lightPrimaryColor,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: const Text("إبدأ الرحلة  ",
                   style: TextStyle(
                     fontSize: 30,
                     color: Colors.white
                   ),),
                 ),
                 
               )
               ,
                const SizedBox(
                  width: 10,
                ),
              //   ElevatedButton(
              //     child: const Text("Start Multi Stop"),
              //     onPressed: () async {
              // //      _isMultipleStop = true;
              //       var wayPoints = <WayPoint>[];
              //       wayPoints.add(_origin);
              //       wayPoints.add(_stop1);
              //       wayPoints.add(_stop2);
              //       wayPoints.add(_stop3);
              //       wayPoints.add(_stop4);
              //       wayPoints.add(_origin);

              //       await _directions!.startNavigation(
              //           wayPoints: wayPoints,
              //           options: MapBoxOptions(
              //               mode: MapBoxNavigationMode.walking,
              //               simulateRoute: true,
              //               language: "en",
              //               allowsUTurnAtWayPoints: true,
              //               units: VoiceUnits.metric));
              //     },
              //   )
              ],
            ),
          ),
        ),
      )
    ;
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions!.distanceRemaining;
    _durationRemaining = await _directions!.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          _instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller!.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}