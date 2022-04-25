import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../components/ButtonWidget.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Geolocator geolocator = Geolocator();

  final PolylinePoints polylinesPoints = PolylinePoints();
  final Set<Polyline> polylines = {};
  double distance = 0.0;
  double speed = 0.0;
  bool startpoly = false;
  late Marker marker;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
    timeLimit: Duration(seconds: 3),
  );

  List<LatLng> runningReccord = [];

  static const countdownDuration = Duration();
  Duration duration = Duration();
  Timer? timer;

  bool countDown = true;

  get positionStream => runningStart(startpoly);

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HEURES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDES'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );
  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 1;
    return isRunning || isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: 'Pause',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                      setState(() {
                        startpoly = false;
                      });
                      runningStart(startpoly);
                    }
                  }),
              SizedBox(
                width: 12,
              ),
              ButtonWidget(
                  text: "ARRETER",
                  onClicked: () {
                    setState(() {
                        startpoly = false;
                      });
                    runningStart(startpoly);
                    stopTimer(resets: true);
                  }),
            ],
          )
        : ButtonWidget(
            text: "Commencer",
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              setState(() {
                        startpoly =true;
                      });
              runningStart(startpoly);
              startTimer();
            });
  }

  @override
  void initState() {
    super.initState();
    reset();
    // ADD POLYLINE

    getPosition();
  }

  runningStart(startpoly) {
    if (startpoly == true) {
      polylines.add(Polyline(
          polylineId: const PolylineId("run"),
          jointType: JointType.round,
          points: runningReccord,
          width: 5,
          color: Colors.deepPurple));
    }
    StreamSubscription<Position> positionStream;
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((userLocation) async {
      var _latitude = userLocation.latitude.toDouble();
      var _longitude = userLocation.longitude.toDouble();
      var speedMps = (userLocation.speed * 3.6);

      //speed calculation

      //polylines distance
      double totalDistance = 0;
      for (var i = 0; i < runningReccord.length - 1; i++) {
        totalDistance += calculateDistance(
            runningReccord[i].latitude,
            runningReccord[i].longitude,
            runningReccord[i + 1].latitude,
            runningReccord[i + 1].longitude);
      }
      if (startpoly == true) {
        setState(() {
          runningReccord.add(LatLng(_latitude, _longitude));
          distance = totalDistance;
          speed = speedMps * 3.6;
        });
      }
      print(startpoly);
      print('---Vitesse--' + speed.toStringAsFixed(2));
      print('----DISTANCE ---:' + totalDistance.toString());
      print(runningReccord);

      print('UPDATED POSITION :' +
          _latitude.toString() +
          ' , ' +
          _longitude.toString());

      // ignore: unused_label
      _googleMapController
          .animateCamera(CameraUpdate.newLatLng(LatLng(_latitude, _longitude)));
    });
  }

  getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _googleMapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      ),
    ));
  }

//CALCUL DISTANCE
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationEnabled: true,
            polylines: polylines,
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(43.604462, 1.444247),
              zoom: 10,
            ),
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              _googleMapController = controller;
              _googleMapController.setMapStyle(Utils.mapStyle);
            },
          ),

          //Card distance,button start,button stop

          Positioned(
            bottom: 70,
            child: Card(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      buildTime(),
                      SizedBox(
                        height: 10,
                      ),
                      buildButtons(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Distance : ' + distance.toStringAsFixed(2) + ' Km',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Vitesse : ' + speed.toStringAsFixed(2) + ' km/h',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }
}

class Utils {
  static String mapStyle = '''
    [  {
    "featureType": "administrative",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#d6e2e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#cfd4d5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#7492a8"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "lightness": 25
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#cfd4d5"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#7492a8"
      }
    ]
  },
  {
    "featureType": "landscape.natural.terrain",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -100
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#588ca4"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a9de83"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#bae6a1"
      }
    ]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#c6e8b3"
      }
    ]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#bae6a1"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -45
      },
      {
        "lightness": 10
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#41626b"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#c1d1d6"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#a6b5bb"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#9fb6bd"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -70
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b4cbd4"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#588ca4"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#008cb5"
      }
    ]
  },
  {
    "featureType": "transit.station.airport",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": -5
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a6cbe3"
      }
    ]
  }
]
  ''';
}
