import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestinationModel {
  final List<LatLng> points;
  final double duration;
  final double distance;

  RouteDestinationModel({
    required this.points,
    required this.duration,
    required this.distance,
  });
}
