import 'package:flutter_mobile_base_structure/data/entity/token_entity.dart';

abstract class AuthenApi {
  Future<TokenEntity> login(String username, String password);
}
