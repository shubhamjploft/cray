import 'package:cray/backend/api_end_points.dart';

String generateFullFileUrl(String? endpoint) {
  if (endpoint == null || endpoint.isEmpty) {
    return 'Invalid endpoint';
  }

  String baseUrl = ApiEndPoints.imagePathUrl;

  if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
    return endpoint;
  } else if (baseUrl.endsWith('/') && endpoint.startsWith('/')) {
    return baseUrl + endpoint.substring(1);
  } else if (!baseUrl.endsWith('/') && !endpoint.startsWith('/')) {
    return '$baseUrl/$endpoint';
  } else {
    return '$baseUrl$endpoint';
  }
}
