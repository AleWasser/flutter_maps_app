import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _accessToken = dotenv.env['MAPBOX_TOKEN'];

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': _accessToken,
    });

    super.onRequest(options, handler);
  }
}
