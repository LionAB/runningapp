import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();

  Stream<Position> getCurrentLocation() {
     var locationSettings=
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
