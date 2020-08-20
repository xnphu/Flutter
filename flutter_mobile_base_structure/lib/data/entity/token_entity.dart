import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_base_structure/domain/model/token_model.dart';

class TokenEntity extends TokenModel {
  TokenEntity({@required String token}) : super(token: token);

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(token: json['access_token']);
  }
}
