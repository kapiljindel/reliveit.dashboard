import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/screens/profile/admin/models/admin_model.dart';

class AdminController {
  final FirebaseFirestore firestore;

  AdminController({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  Future<AdminModel?> fetchAdmin(String uid) async {
    final doc = await firestore.collection('users').doc('Admin').get();

    if (!doc.exists) return null;

    final data = doc.data() ?? {};
    final adminMap = data[uid];

    if (adminMap == null) return null;

    return AdminModel.fromMap(uid, Map<String, dynamic>.from(adminMap));
  }

  Future<void> saveAdmin(AdminModel admin) async {
    final docRef = firestore.collection('users').doc('Admin');
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({admin.uid: admin.toMap()});
    } else {
      final currentData = doc.data()!;
      currentData[admin.uid] = admin.toMap();

      await docRef.update(currentData);
    }
  }

  Future<void> updateAdminImageUrl(String uid, String newUrl) async {
    final admin = await fetchAdmin(uid);
    if (admin == null) return;

    final updatedAdmin = admin.copyWith(imageUrl: newUrl);
    await saveAdmin(updatedAdmin);
  }
}
