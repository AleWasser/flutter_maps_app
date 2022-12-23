import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _accessToken = dotenv.env['MAPBOX_TOKEN'];

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': _accessToken,
      'language': 'en',
    });

    super.onRequest(options, handler);
  }
}
