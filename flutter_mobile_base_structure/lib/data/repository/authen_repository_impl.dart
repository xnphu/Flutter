import 'package:dartz/dartz.dart';
import 'package:flutter_mobile_base_structure/core/error/failures.dart';
import 'package:flutter_mobile_base_structure/core/network/network_status.dart';
import 'package:flutter_mobile_base_structure/data/datasource/api/interface_api.dart';
import 'package:flutter_mobile_base_structure/data/datasource/authen_cache.dart';
import 'package:flutter_mobile_base_structure/domain/model/token_model.dart';
import 'package:flutter_mobile_base_structure/domain/repository/authen_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenApi _authenApi;
  AuthenCache _authenCache;

  AuthenticationRepositoryImpl(this._authenApi, this._authenCache)
      : assert(_authenApi != null),
        assert(_authenCache != null);

  @override
  Future<TokenModel> login(String username, String password) async {
    assert((username?.isNotEmpty ?? false), 'username is null');
    assert((password?.isNotEmpty ?? false), 'password is null');
    final token = await _authenApi.login(username, password);
    _authenCache.putToken(token);
    return token;
  }

  @override
  Future<TokenModel> getCachedToken() async {
    var token = await _authenCache.getCachedToken();
    return token;
  }

  @override
  logout() async {
    _authenCache.removeToken();
  }
}
