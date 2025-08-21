import 'package:flutter/material.dart';

class ProfileControllers {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController uidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    uidController.dispose();
    passwordController.dispose();
  }
}
