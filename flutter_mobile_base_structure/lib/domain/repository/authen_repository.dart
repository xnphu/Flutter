import '../model/token_model.dart';

abstract class AuthenticationRepository {
//  Future<TokenModel> login(String username, String password);
  Future<String> login({String email, String password});
  Future<String> getCachedToken();
  Future<void> logOut();
}
