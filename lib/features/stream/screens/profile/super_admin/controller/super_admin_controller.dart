import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuperAdminController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController();
  final passwordController = TextEditingController();
  final imageUrlController = TextEditingController();

  Map<String, dynamic> adminData = {};
  List<Map<String, dynamic>> admins = [];

  bool isPasswordVisible = false;
  bool isEditing = false;
  bool loading = true;

  Future<void> fetchSuperAdminData(
    String superUid,
    VoidCallback onUpdate,
  ) async {
    final doc = await firestore.collection('users').doc('Super').get();
    final data = doc.data() ?? {};
    final admin = data[superUid] ?? {};

    if (admin.isEmpty) {
      loading = false;
      onUpdate();
      return;
    }

    adminData = admin;
    nameController.text = admin['displayName'] ?? '';
    emailController.text = admin['email'] ?? '';
    uidController.text = superUid;
    passwordController.text = admin['password'] ?? '';
    loading = false;
    onUpdate();
  }

  Future<void> fetchAdmins(VoidCallback onUpdate) async {
    final doc = await firestore.collection('users').doc('Admin').get();
    final data = doc.data() ?? {};

    List<Map<String, dynamic>> fetchedAdmins = [];
    data.forEach((uid, details) {
      final userMap = Map<String, dynamic>.from(details);
      fetchedAdmins.add({
        'uid': uid,
        'name': userMap['displayName'] ?? '',
        'email': userMap['email'] ?? '',
        'image': userMap['imageUrl'] ?? '',
        'permissions': Map<String, bool>.from(userMap['permissions'] ?? {}),
      });
    });

    admins = fetchedAdmins;
    onUpdate();
  }

  Future<void> deleteAdmin(String uid, VoidCallback onUpdate) async {
    await firestore.collection('users').doc('Admin').update({
      uid: FieldValue.delete(),
    });
    await fetchAdmins(onUpdate);
  }

  Future<void> saveSuperAdminData(
    String superUid,
    VoidCallback onUpdate,
  ) async {
    final updatedData = {
      'displayName': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'imageUrl': adminData['imageUrl'] ?? '',
    };

    await firestore.collection('users').doc('Super').update({
      superUid: updatedData,
    });

    isEditing = false;
    await fetchSuperAdminData(superUid, onUpdate);
  }

  Future<void> togglePermission(
    String adminUid,
    String key,
    bool value,
    VoidCallback onUpdate,
  ) async {
    await firestore.collection('users').doc('Admin').update({
      '$adminUid.permissions.$key': !value,
    });

    await fetchAdmins(onUpdate);
  }
}
