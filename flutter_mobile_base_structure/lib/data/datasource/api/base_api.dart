export 'package:flutter_mobile_base_structure/data/net/api_connection.dart';
export 'package:flutter_mobile_base_structure/data/net/api_endpoint_input.dart';
import 'package:flutter_mobile_base_structure/core/error/exceptions.dart';
import 'package:flutter_mobile_base_structure/core/error/failures.dart';

import '../authen_cache.dart';
import 'api_config.dart';

abstract class BaseApi {
  ApiConfigImpl apiCofig = ApiConfigImpl();

  Map<String, String> defaultHeader(
      {String token, String contentType = 'application/json'}) {
    var header = {
      'Content-Type': contentType,
    };
    if (token?.isNotEmpty ?? false) {
      header['x-access-token'] = '$token';
    }
    return header;
  }

  Future<String> validateAccessToken(AuthenCache authenCache) async {
    final token = (await authenCache.getCachedToken()).token;
    if (token.isEmpty) {
      throw CacheException(errorMessage: TOKEN_EMPTY_ERROR);
    }
    return token;
  }

  Future<Map<String, String>> buildHeader({AuthenCache authenCache}) async {
    if (authenCache == null) return defaultHeader();
    final token = await validateAccessToken(authenCache);
    var header = defaultHeader(token: token);
    return header;
  }
}
