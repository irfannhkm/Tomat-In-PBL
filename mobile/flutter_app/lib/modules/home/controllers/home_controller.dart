import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tomatin/utils/location_services.dart';

class HomeController extends GetxController {
  final LocationServices locationServices = LocationServices();
  var cityName = 'Mendapatkan lokasi...'.obs;

  @override
  void onInit() {
    super.onInit();
    _getCityName();
  }

  Future<void> _getCityName() async {
    try {
      final Position? position = await locationServices.getCurrentLocation();
      if (position != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          cityName.value = placemarks.first.locality ?? "Kota tidak diketahui";
        } else {
          cityName.value = "Kota tidak ditemukan";
        }
      } else {
        cityName.value = "Lokasi tidak tersedia";
      }
    } catch (e) {
      cityName.value = "Error fetching kota: $e";
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) {
      return 'Selamat Pagi,';
    } else if (hour >= 11 && hour < 16) {
      return 'Selamat Siang,';
    } else if (hour >= 16 && hour < 19) {
      return 'Selamat Sore,';
    } else {
      return 'Selamat Malam,';
    }
  }
}