import 'package:dashboard/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:dashboard/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout: false,
      desktop: ResetPasswordScreenDesktopTablet(),
      mobile: ResetPasswordScreenMobile(),
    );
  }
}
