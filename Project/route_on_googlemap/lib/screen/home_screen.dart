import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_on_googlemap/utils/check_location_permission.dart';
import 'package:route_on_googlemap/component/route_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraPosition initialPosition =
      CameraPosition(target: appleLatLng, zoom: 13.5);
  static final LatLng appleLatLng = LatLng(
    37.3326935, // Latitude
    -122.0110225, // Longitude
  );

  List<LatLng> currentLocationList = []; // 위치 바뀔 때마다 저장
  Set<Polyline> polylines = Set<Polyline>(); // poly lines
  PolylinePoints polylinePoints = PolylinePoints(); //
  List<LatLng> polylineCoordinates = [];
  PointLatLng? srcPoint;
  bool permissionAllow = false; // 위치권한 허용 됐는지 체크
  String permission = "Permission이 세팅되지 않았습니다."; // 위치권한 허용 문구 (에러 표시할 때 사용)
  GoogleMapController? mapController;

  @override
  void initState() {
    getPolylineStream();
  }

  getPolylineStream() async {
    permission = await checkLocationPermission();
    if(permission != "위치 권한이 허가 되었습니다.") {
      permissionAllow = false;
      return null;
    }
    setState(() {
      permissionAllow = true;
    });
    Geolocator.getPositionStream(locationSettings: LocationSettings(timeLimit: Duration(seconds: 5))).listen((event) {
      currentLocationList.add(LatLng(event.latitude, event.longitude));

      if (currentLocationList.length > 1) {
        srcPoint ??= PointLatLng(currentLocationList.first.latitude,
            currentLocationList.first.longitude);
        // 가장 마지막 최근에 기록된 위도경도를 destPoint로 지정
        PointLatLng destPoint = PointLatLng(
            currentLocationList[currentLocationList.length - 1].latitude,
            currentLocationList[currentLocationList.length - 1].longitude);
        final distance = Geolocator.distanceBetween(
            srcPoint!.latitude,
            srcPoint!.longitude,
            destPoint.latitude,
            destPoint.longitude); // m 단위로 return
        if (distance > 200) {
            // srcPoint와 destPoint가 250 이상으로 거리가 늘어났을 경우 실행
            initialPosition = CameraPosition(
                target: currentLocationList.last,
                zoom: 13.5); // 가장 마지막 위치로 initialPosition 변경
          _getPolyline(srcPoint: srcPoint!, destPoint: destPoint);
          srcPoint = PointLatLng(
              currentLocationList[currentLocationList.length - 2].latitude,
              currentLocationList[currentLocationList.length - 2].longitude);
        }
      }
    });
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (permissionAllow)
          ? RouteMap(polylines: polylines, initialCameraPosition: initialPosition)
          : Container(child: Center(child: Text(permission),),),

      // FutureBuilder<String>(
      //     future: checkLocationPermission(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState != ConnectionState.done) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (snapshot.data != null &&
      //           !(event == LocationPermission.always.name ||
      //               snapshot.data == LocationPermission.whileInUse.name)) {
      //         return Center(
      //           child: Text(event),
      //         );
      //       } else if (snapshot.data == null) {
      //         return Center(
      //           child: Text('알 수 없는 오류 입니다.'),
      //         );
      //       }
      //
      //       return RouteMap(
      //         initialCameraPosition: initialPosition,
      //         polylines: polylines,
      //       );
      //     }),
    );
  }

  _getPolyline(
      {required PointLatLng srcPoint, required PointLatLng destPoint}) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB3ocH1nB3VHLM0XxXw5B6lu7bSpkFq1kI",
      srcPoint,
      destPoint,
    );
    print(result.points);
    if (result.status == "OK") {
      print('PolylineResult status : OK');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId("polyline"),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }
}
