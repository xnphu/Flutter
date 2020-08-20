import 'package:flutter_mobile_base_structure/core/network/network_status.dart';
import 'package:flutter_mobile_base_structure/data/entity/token_entity.dart';
import 'package:flutter_mobile_base_structure/data/datasource/api/base_api.dart';
import 'package:flutter_mobile_base_structure/data/net/api_connection.dart';
import 'package:flutter_mobile_base_structure/data/net/api_endpoint_input.dart';

import 'interface_api.dart';

class AuthenApiImpl extends AuthenApi with BaseApi {
  NetworkStatus networkStatus;
  AuthenApiImpl({this.networkStatus});

  @override
  Future<TokenEntity> login(String username, String password) async {
    var params = {'ten_truy_cap': username, 'mat_khau': password};
    var header = await buildHeader();
    final json = await ApiConnection(apiCofig, networkStatus: networkStatus)
        .execute(new ApiInput('/auth/signin', ApiMethod.post, header, params));
    return TokenEntity.fromJson(json);
  }
}
