import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Map<PolylineId, Polyline> getPolyline({required Map<PolylineId, Polyline> polylines,required PointLatLng srcPoint, required PointLatLng destPoint}) async {
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB3ocH1nB3VHLM0XxXw5B6lu7bSpkFq1kI", srcPoint, destPoint,
      travelMode: TravelMode.driving,
      wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }
}