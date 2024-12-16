import 'package:geolocator/geolocator.dart';
import 'package:tomatin/config.dart';

class LocationServices {
  final String baseUrl = Config.API_Url;
  // final url = Uri.parse("$baseUrl/v1/user/locations");
  Position? currentLocation;

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentLocation() async {
    bool isServiceEnabled;
    bool isPermissionGranted;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    isPermissionGranted = await checkLocationPermission();
    if (!isPermissionGranted) {
      return Future.error('Location permissions are denied');
    }

    currentLocation = await Geolocator.getCurrentPosition();

    return currentLocation;
  }
}
