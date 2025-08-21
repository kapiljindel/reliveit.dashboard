import 'dart:io';
import 'package:dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:dashboard/features/authentication/controllers/user_controller.dart';
import 'package:dashboard/features/network/network_manager.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/popups/full_screen_loader.dart';
import 'package:dashboard/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  /// Login and Save Credentials to Local File (only on successful login)
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loader
      TFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        TImages.docerAnimation,
      );

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection.',
        );
        return;
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userEmail = email.text.trim();
      final userPassword = password.text.trim();

      // Firebase login
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        userEmail,
        userPassword,
      );

      // Fetch user
      final user = await UserController.instance.fetchUserDetails();

      // Role check
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Access Denied',
          message: 'You are not authorized to access this app.',
        );
        return;
      }

      // ✅ Save to local file
      await _saveCredentialsToFile(userEmail, userPassword);

      // Stop loader
      TFullScreenLoader.stopLoading();

      // Navigate to dashboard
      Get.offAllNamed('/dashboard');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Login Failed', message: e.toString());
    }
  }

  /// Save credentials to a file in app's document directory
  Future<void> _saveCredentialsToFile(String email, String password) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/credentials.txt');

      final content = 'email=$email\npassword=$password';
      await file.writeAsString(content);

      print('✅ Credentials saved to: ${file.path}');
    } catch (e) {
      print('❌ Error saving credentials: $e');
    }
  }
}
