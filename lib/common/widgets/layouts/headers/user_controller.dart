import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_model.dart';

class HeaderUserController extends GetxController {
  static HeaderUserController get instance => Get.find();

  final Rx<HeaderUserModel> user =
      HeaderUserModel(displayName: '', imageUrl: '', email: '').obs;

  final RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      loading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');
      final role = prefs.getString('role');

      if (uid == null || role == null) {
        throw Exception('Missing UID or role');
      }

      final doc =
          await FirebaseFirestore.instance.collection('users').doc(role).get();

      if (!doc.exists) {
        throw Exception('User role not found');
      }

      final userData = (doc.data()?[uid]) ?? {};
      user.value = HeaderUserModel.fromMap(userData);
    } catch (e) {
      print('Error fetching user: $e');
    } finally {
      loading.value = false;
    }
  }
}
