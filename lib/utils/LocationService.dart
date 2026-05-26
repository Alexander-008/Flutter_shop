import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  String _currentAddress = '西永街道西科公寓';

  String get currentAddress => _currentAddress;

  Future<bool> requestPermission() async {
    if (kIsWeb) {
      return true;
    }

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async {
    if (kIsWeb) {
      return null;
    }

    try {
      bool hasPermission = await requestPermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      debugPrint('获取位置失败: $e');
      return null;
    }
  }

  Future<String> getCurrentAddress() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String address = '';

          if (place.administrativeArea != null) {
            address += place.administrativeArea!;
          }
          if (place.locality != null) {
            address += place.locality!;
          }
          if (place.subLocality != null) {
            address += place.subLocality!;
          }
          if (place.thoroughfare != null) {
            address += place.thoroughfare!;
          }
          if (place.subThoroughfare != null) {
            address += place.subThoroughfare!;
          }

          if (address.isNotEmpty) {
            _currentAddress = address;
            return _currentAddress;
          }
        }
      } catch (e) {
        debugPrint('地理编码失败: $e');
      }
    }

    return _currentAddress;
  }

  void setAddress(String address) {
    _currentAddress = address;
  }
}
