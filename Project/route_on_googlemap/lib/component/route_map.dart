import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMap extends StatelessWidget {
  CameraPosition initialCameraPosition;
  Set<Polyline> polylines;
  RouteMap({required this.polylines, required this.initialCameraPosition, Key? key}) : super(key: key);

  GoogleMapController? mapController;

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

    @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: onMapCreated,
      initialCameraPosition: initialCameraPosition,
      polylines: polylines,
    );
  }
}
