import 'package:myapp/models/user.dart';

import '../contracts/abs_auth_repository.dart';

class ApiAuthRepository extends AbsAuthRepository {
  @override
  Future<(bool, String)> forgotPassword(String username) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<User?> info([bool force = false]) {
    // TODO: implement info
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    // TODO: implement isAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<(bool, String)> login(UserLoginDto dataLogin) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<(bool, String)> register(UserRegisterDto dataRegister) {
    // TODO: implement register
    throw UnimplementedError();
  }
}