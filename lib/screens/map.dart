import 'package:flutter/material.dart';
import 'package:my_app/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Map> {
  final GeolocatorService geoServices = GeolocatorService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Position>(
          stream: geoServices.getCurrentLocation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Center(
              child: Text(
                  '${snapshot.data.latitude}, Lng: ${snapshot.data.longitude}',
                  style: TextStyle(fontSize:20.0),
                  ),
            );
          }),
    );
  }
}
