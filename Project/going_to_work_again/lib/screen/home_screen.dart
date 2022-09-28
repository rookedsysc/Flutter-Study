import 'package:flutter/material.dart';
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
        body: Column(
          children: [
            _CustomGoogleMap(initialPosition: initialPosition,),
            _ChoolCheckButton()
          ],
        ));
  }
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
  const _CustomGoogleMap({required this.initialPosition, Key? key}) : super(key: key);
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
