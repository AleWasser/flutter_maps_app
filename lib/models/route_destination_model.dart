import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/places_response_model.dart';

class RouteDestinationModel {
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature destinationPlace;

  RouteDestinationModel(
      {required this.points,
      required this.duration,
      required this.distance,
      required this.destinationPlace});
}
