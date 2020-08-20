import 'package:flutter_mobile_base_structure/data/net/api_connection.dart';

import 'base_api.dart';

class ApiConfigImpl extends ApiConfig {
  static final ApiConfig _shared = new ApiConfigImpl._internal();
  factory ApiConfigImpl() {
    return _shared;
  }
  ApiConfigImpl._internal();

  String baseUrl = 'http://192.168.0.103:3000/api/v1';
  int connectTimeout = 50000;
  int receiveTimeout = 30000;
}
