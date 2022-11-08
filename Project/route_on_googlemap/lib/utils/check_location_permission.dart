import 'package:geolocator/geolocator.dart';

Future<String> checkLocationPermission() async {
  // 권한 요청과 관련된 모든 요청은 async로 작업함.
  final isLocationEnabled =
  await Geolocator.isLocationServiceEnabled(); // 위치 서비스 활성화 유/무

  if (!isLocationEnabled) {
    return '위치 서비스를 활성화 해주세요.';
  }

  LocationPermission checkedPermission =
  await Geolocator.checkPermission(); // 위치 서비스 권한 확인

  if (checkedPermission == LocationPermission.denied) {
    // Permission 요청을 할 수 있는 상태
    checkedPermission = await Geolocator.requestPermission(); // 권한 요청하는 함수

    if (checkedPermission == LocationPermission.denied) {
      return '위치 권한을 허가해주세요.';
    }
  }

  if (checkedPermission == LocationPermission.deniedForever) {
    return '위치 권한을 세팅에서 허가해주세요.';
  }

  return checkedPermission.name;
}

