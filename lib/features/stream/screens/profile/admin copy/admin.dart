import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';
import 'package:dashboard/features/stream/screens/profile/admin/responsive_screens/admin_desktop_screen.dart';
import 'package:dashboard/features/stream/screens/profile/admin/responsive_screens/admin_mobile_screen.dart';
import 'package:dashboard/features/stream/screens/profile/admin/responsive_screens/admin_tablet_screen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<String?> _getUid() async {
    final user = await FirebaseAuthService.getStoredUser();
    return user['uid'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('User UID not found')),
          );
        } else {
          final uid = snapshot.data!;
          return TSiteTemplate(
            desktop: AdminDesktopScreen(uid: uid),
            tablet: AdminTabletScreen(uid: uid),
            mobile: AdminMobileScreen(uid: uid),
          );
        }
      },
    );
  }
}
