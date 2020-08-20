import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_base_structure/domain/model/token_model.dart';

abstract class AuthenCache {
  Future<TokenModel> getCachedToken();
  void putToken(TokenModel token);
  void removeToken();
}

class AuthenCacheImpl extends AuthenCache {
  TokenModel _token;
  AuthenCacheImpl();

  @override
  Future<TokenModel> getCachedToken() async {}

  @override
  void putToken(TokenModel token) {}

  @override
  removeToken() async {}
}
