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
  bool choolCheckDone = false; // 출근 체크 상태 관리

  // 우주에서부터 지구를 바라보는 시점.
  // google 맵이 시작되는 위치를 명시해줌.
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLatLng, zoom: 15); // zoom 값이 커질수록 가까이서 보임.

  static final double okDistance = 100;

  // 지도에 원을 그려줌
  static final Circle withinDistanceCircle = Circle(
    circleId: CircleId('withinDistanceCircle '), // 화면에 여러개의 동그라미를 그렸을 때 같은 동그라미인지 확인
    center: companyLatLng, //
    fillColor: Colors.blue.withOpacity(0.5), // 투명도

    radius: okDistance, // 반지름 (Meter 단위)
    strokeColor: Colors.blue, // 원의 둘레 색상
    strokeWidth: 1, // 원 둘레의 두께
  );
  static final Circle notWithinDistanceCircle = Circle(
    circleId: CircleId('notWithinDistanceCircle '), // 화면에 여러개의 동그라미를 그렸을 때 같은 동그라미인지 확인
    center: companyLatLng, //
    fillColor: Colors.red.withOpacity(0.5), // 투명도
    radius: okDistance, // 반지름 (Meter 단위)
    strokeColor: Colors.red, // 원의 둘레 색상
    strokeWidth: 1, // 원 둘레의 두께
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle '), // 화면에 여러개의 동그라미를 그렸을 때 같은 동그라미인지 확인
    center: companyLatLng, //
    fillColor: Colors.green.withOpacity(0.5), // 투명도
    radius: okDistance, // 반지름 (Meter 단위)
    strokeColor: Colors.green, // 원의 둘레 색상
    strokeWidth: 1, // 원 둘레의 두께
  );

  // 지도에 화살표 표시해줌.
  static final Marker marker =
      Marker(markerId: MarkerId('marker'), position: companyLatLng);

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
          print(
              '##### snapshot.connectionState ##### \n${snapshot.connectionState}');
          print('##### sapshot.data ##### \n${snapshot.data}');

          // 로딩 중 일때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // 위치 권한이 허가 되었을 때
          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                // getPositionStream이 Position Generic
                // 위치가 바뀔 때 마다 불러와서 snapshot.data에 저장해줌.
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false; // Circle 안에 위치해 있는지

                  if (snapshot.hasData) {
                    final start = snapshot.data!; // 내 현재 위치
                    final end = companyLatLng; // 회사 위치

                    final distance = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude); // start <> end 사이의 거리를 구해줌.
                    if (distance < okDistance) {
                      // okDistance(100)보다 거리가 작으면 현재 핸드폰이 거리 안에 들어가 있음.
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        // chooCheckDone이 true면 나머지 값을 보지도 않고 checkDoneCircle을 사용
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : isWithinRange
                                    ? withinDistanceCircle
                                    : notWithinDistanceCircle,
                        // 거리 안에 있으면 파란색 원 : 거리 밖에 있으면 빨간색 원
                        marker: marker,
                      ),
                      _ChoolCheckButton(
                        onPressed: onChoolCheckPressed,
                        choolCheckDone: choolCheckDone,
                        isWithinRange: isWithinRange,
                      ),
                    ],
                  );
                });
          }
          // 위치 권한이 허가가 안되었을 때
          return Center(
            child: Text(snapshot.data), // checkPermission의 return 값 화면에 띄워줌.
          );
        },
      ),
    );
  }

  // Material Alert Dialog
  // 출근 버튼 누르면 동작하는 알람
  onChoolCheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          // Button 아래에 배치 순서대로 왼쪽부터 정렬
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('취소')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('출근하기'))
          ],
        );
      },
    );
    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
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
  const _CustomGoogleMap(
      {required this.marker,
      required this.circle,
      required this.initialPosition,
      Key? key})
      : super(key: key);
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        // hybrid - 위성, satellite - 위성,
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        // 내 위치권한 활성화.
        myLocationButtonEnabled: false,
        // 내 위치권한 Button.
        circles: Set.from([circle]),
        // list 안에 여러 값을 넣으면 다수의 원 생성 가능.
        markers: Set.from([marker]), // marker 넣어줌.
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton(
      {required this.choolCheckDone, required this.onPressed, required this.isWithinRange, Key? key})
      : super(key: key);
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50.0,
            color: choolCheckDone ? Colors.green : isWithinRange
                ? Colors.blue
                : Colors.red, // 거리 내에 있으면 파랑, 아니면 빨강
          ),
          SizedBox(
            height: 20.0,
          ),
          if (!choolCheckDone && isWithinRange)
            TextButton(onPressed: onPressed, child: Text('출근하기'))
        ],
      ),
    );
  }
}
