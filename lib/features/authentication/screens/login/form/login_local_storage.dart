import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalStorage {
  static const _emailKey = 'login_email';
  static const _passwordKey = 'login_password';
  static const _rememberMeKey = 'login_remember_me';

  /// Save credentials if rememberMe is true, otherwise clear
  static Future<void> saveCredentials(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString(_emailKey, email);
      await prefs.setString(_passwordKey, password);
      await prefs.setBool(_rememberMeKey, true);
    } else {
      await prefs.remove(_emailKey);
      await prefs.remove(_passwordKey);
      await prefs.setBool(_rememberMeKey, false);
    }
  }

  /// Load credentials if available
  static Future<Map<String, dynamic>> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey) ?? '';
    final password = prefs.getString(_passwordKey) ?? '';
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;

    return {'email': email, 'password': password, 'rememberMe': rememberMe};
  }

  /// Clear all saved credentials
  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.remove(_rememberMeKey);
  }
}
