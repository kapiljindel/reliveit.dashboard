import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class LoggedInUserPage extends StatefulWidget {
  const LoggedInUserPage({super.key});

  @override
  State<LoggedInUserPage> createState() => _LoggedInUserPageState();
}

class _LoggedInUserPageState extends State<LoggedInUserPage> {
  String? uid;
  String? displayName;
  String? role;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await FirebaseAuthService.getStoredUser();
    setState(() {
      uid = user['uid'];
      displayName = user['displayName'];
      role = user['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UID: $uid'),
            Text('Display Name: $displayName'),
            Text('Role: $role'),
          ],
        ),
      ),
    );
  }
}
