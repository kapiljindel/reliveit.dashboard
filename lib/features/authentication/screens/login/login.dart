import 'package:dashboard/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:dashboard/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout: false,
      desktop: LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
