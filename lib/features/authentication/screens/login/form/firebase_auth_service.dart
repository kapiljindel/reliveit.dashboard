import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  static const _uidKey = 'uid';
  static const _displayNameKey = 'displayName';
  static const _roleKey = 'role';

  /// Login method: checks both Admin and Super
  static Future<String?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final roles = ['Admin', 'Super'];

    for (final role in roles) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(role).get();
      if (!doc.exists) continue;

      final data = doc.data()!;
      for (var entry in data.entries) {
        final uid = entry.key;
        final user = Map<String, dynamic>.from(entry.value);

        final userEmail = user['email']?.toString().trim();
        final userPassword = user['password']?.toString().trim();

        if (userEmail == email && userPassword == password) {
          await _storeSession(uid, user['displayName'] ?? 'Unknown', role);
          return uid;
        }
      }
    }

    return null; // No match
  }

  static Future<void> _storeSession(
    String uid,
    String displayName,
    String role,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, uid);
    await prefs.setString(_displayNameKey, displayName);
    await prefs.setString(_roleKey, role);
  }

  static Future<Map<String, String?>> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'uid': prefs.getString(_uidKey),
      'displayName': prefs.getString(_displayNameKey),
      'role': prefs.getString(_roleKey),
    };
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_uidKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uidKey);
    await prefs.remove(_displayNameKey);
    await prefs.remove(_roleKey);
  }
}
