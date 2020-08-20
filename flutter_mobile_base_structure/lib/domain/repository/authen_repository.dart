import '../model/token_model.dart';

abstract class AuthenticationRepository {
  Future<TokenModel> login(String username, String password);
}
