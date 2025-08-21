import 'package:dashboard/features/authentication/screens/login/form/authentication_repository.dart';
import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';
//import 'package:dashboard/features/authentication/screens/login/form/login_local_storage.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Form Key
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Text Controllers
  final email = TextEditingController();
  final password = TextEditingController();

  // Reactive values
  var hidePassword = true.obs;
  var rememberMe = false.obs;

  // Login action
  Future<void> emailAndPasswordSignIn() async {
    if (!loginFormKey.currentState!.validate()) return;

    final userEmail = email.text.trim();
    final userPassword = password.text.trim();

    try {
      final uid = await FirebaseAuthService.loginWithEmailAndPassword(
        userEmail,
        userPassword,
      );

      if (uid != null) {
        // Update authentication state
        await AuthenticationRepository.instance.checkAuthStatus();

        // Navigate to dashboard or any protected route
        Get.offAllNamed(TRoutes.dashboard);
      } else {
        Get.snackbar('Login Failed', 'Invalid email or password');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
