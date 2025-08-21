import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';

class AuthenticationRepository {
  AuthenticationRepository._privateConstructor();

  static final AuthenticationRepository instance =
      AuthenticationRepository._privateConstructor();

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuthStatus() async {
    _isAuthenticated = await FirebaseAuthService.isLoggedIn();
  }

  Future<void> logout() async {
    await FirebaseAuthService.logout();
    _isAuthenticated = false;
  }
}
