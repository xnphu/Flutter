import 'package:flutter_mobile_base_structure/data/datasource/api/interface_api.dart';
import 'package:flutter_mobile_base_structure/data/datasource/authen_cache.dart';
import 'package:flutter_mobile_base_structure/data/datasource/firebaseApi/firebase_api.dart';
import 'package:flutter_mobile_base_structure/domain/model/token_model.dart';
import 'package:flutter_mobile_base_structure/domain/repository/authen_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  FirebaseApi _firebaseApi;
  AuthenApi _authenApi;
  AuthenCache _authenCache;

  AuthenticationRepositoryImpl( this._firebaseApi, this._authenCache);

  @override
  Future<String> login({String email, String password}) async {
    final token = await _firebaseApi.signInWithEmailAndPassword(email: email, password: password);
    _authenCache.putToken(token);
    return token;
  }

  @override
  Future<String> getCachedToken() async {
    String token = await _authenCache.getCachedToken();
    return token;
  }

  @override
  Future<void> logOut() async {
    await _firebaseApi.logOut();
    _authenCache.removeToken();
  }

//  AuthenticationRepositoryImpl(this._authenApi, this._authenCache)
//      : assert(_authenApi != null),
//        assert(_authenCache != null);

//  @override
//  Future<TokenModel> login(String username, String password) async {
//    assert((username?.isNotEmpty ?? false), 'username is null');
//    assert((password?.isNotEmpty ?? false), 'password is null');
//    final token = await _authenApi.login(username, password);
//    _authenCache.putToken(token);
//    return token;
//  }

//  @override
//  Future<TokenModel> getCachedToken() async {
//    var token = await _authenCache.getCachedToken();
//    return token;
//  }

//  @override
//  logout() async {
//    _authenCache.removeToken();
//  }
}
