import 'package:dartz/dartz.dart';
import 'package:eco/features/authentication/data/repo/auth_service.dart';
import 'package:eco/features/authentication/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<Either<String, User>> loginWithEmail(String email, String password) {
    return _authService.loginWithEmail(email, password);
  }

  Future<Either<String, User>> registerWithEmail(
      String email, String password) {
    return _authService.registerWithEmail(email, password);
  }

  Future<Either<String, User>> loginWithGoogle() {
    return _authService.loginWithGoogle();
  }

  Future<Either<String, void>> resetPassword(String email) {
    return _authService.resetPassword(email);
  }

  Future<Either<String, void>> signOut() {
    return _authService.signOut();
  }

  Future<Either<String, UserModel>> getCurrentUser(String uid) async {
    return _authService.getCurrentUser(uid);
  }

  Future<Either<String, UserModel>> setUser(User user) async {
    return _authService.setUser(user);
  }
}
