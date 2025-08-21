import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';
import 'package:dashboard/features/stream/screens/profile/admin/admin.dart';
import 'package:dashboard/features/stream/screens/profile/super_admin/supper_admin.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<Widget> _getPage() async {
    final isLoggedIn = await FirebaseAuthService.isLoggedIn();

    if (!isLoggedIn) {
      return const Scaffold(body: Center(child: Text('User not logged in')));
    }

    final user = await FirebaseAuthService.getStoredUser();
    final uid = user['uid'];
    final role = user['role'];

    if (uid == null || role == null) {
      return const Scaffold(body: Center(child: Text('Missing user info')));
    }

    switch (role) {
      case 'Super':
        return const SuperAdminPage();
      case 'Admin':
        return const AdminPage();
      default:
        return const Scaffold(body: Center(child: Text('Unknown role')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
