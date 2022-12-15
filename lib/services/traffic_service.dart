import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;
  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponseModel> getCoordsStartToEnd(
    LatLng start,
    LatLng end,
  ) async {
    final coordsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coordsString';

    final response = await _dioTraffic.get(url);
    final data = TrafficResponseModel.fromMap(response.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(
    LatLng proximity,
    String query,
  ) async {
    if (query.isEmpty) return [];
    final url = '$_basePlacesUrl/$query.json';
    final response = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${proximity.longitude}, ${proximity.latitude}'
    });
    final placesResponse = PlacesResponseModel.fromMap(response.data);

    return placesResponse.features;
  }
}
