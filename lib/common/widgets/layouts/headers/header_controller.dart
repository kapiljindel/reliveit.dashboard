import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/common/widgets/layouts/headers/header_model.dart';
import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';

class UserController {
  static Future<UserModel?> fetchLoggedInUser() async {
    final stored = await FirebaseAuthService.getStoredUser();
    final uid = stored['uid'];
    final role = stored['role'];

    if (uid == null || role == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(role).get();
    final data = doc.data();

    if (data == null || !data.containsKey(uid)) return null;

    return UserModel.fromMap(uid, role, Map<String, dynamic>.from(data[uid]));
  }
}
