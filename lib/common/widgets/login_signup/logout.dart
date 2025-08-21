import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dashboard/routes/routes.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  Future<void> _logoutAndRedirect() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear stored data
    Get.offAllNamed(TRoutes.login); // Navigate to login and clear history
  }

  @override
  Widget build(BuildContext context) {
    // Automatically trigger logout when this widget loads
    _logoutAndRedirect();

    // Show a loading indicator while logging out
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
