import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // latitude - 위도, Longitude - 경도
  static final LatLng companyLatLng = LatLng(
    37.5233273, // Latitude
    126.921252, // Longitude
  );

  // 우주에서부터 지구를 바라보는 시점.
  // google 맵이 시작되는 위치를 명시해줌.
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLatLng, zoom: 15); // zoom 값이 커질수록 가까이서 보임.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder(
        // future를 return을 해주는 method를 넣을 수 있고 변경될 때마다 builder를 다시 실행해서 화면을 다시 그려줄 수 있음.
        // snapshotreturn해주는 값을 지속적으로 넣어줌.
        future: checkPermission(), // checkPermission() 상태가 바뀔 때마다 builder가 재실행.
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // waiting - Future가 로딩 중, done - 함수 실행이 다 끝났음.
          print('##### snapshot.connectionState ##### \n${snapshot.connectionState}');
          print('##### sapshot.data ##### \n${snapshot.data}');

          // 로딩 중 일때
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // 위치 권한이 허가 되었을 때
          if(snapshot.data == '위치 권한이 허가되었습니다.') {
            return Column(
              children: [
                _CustomGoogleMap(
                  initialPosition: initialPosition,
                ),
                _ChoolCheckButton(),
              ],
            );
          }
          // 위치 권한이 허가가 안되었을 때
          return Center(
            child: Text(snapshot.data), // checkPermission의 return 값 화면에 띄워줌.
          );
        },
      ),
    );
  }

  // 위치 설정권한 확인
  Future<String> checkPermission() async {
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
      return '앱을 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다.';
  }

  // 앱바
  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  const _CustomGoogleMap({required this.initialPosition, Key? key})
      : super(key: key);
  final CameraPosition initialPosition;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        // hybrid - 위성, satellite - 위성,
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text('출근'));
  }
}
