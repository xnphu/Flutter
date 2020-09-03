import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_base_structure/domain/model/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenCache {
  Future<String> getCachedToken();
  void putToken(String token);
  void removeToken();
}

class AuthenCacheImpl extends AuthenCache {
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  AuthenCacheImpl();

  @override
  Future<String> getCachedToken() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String token = await prefs.get('token');
    return token;
  }

  @override
  void putToken(String token) async {
    final SharedPreferences prefs = await _sharedPreferences;
    await prefs.setString('token', token);
  }

  @override
  removeToken() async {
    final SharedPreferences prefs = await _sharedPreferences;
    await prefs.remove('token');
  }
}
