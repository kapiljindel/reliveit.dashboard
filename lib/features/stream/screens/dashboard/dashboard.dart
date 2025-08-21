import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:dashboard/features/stream/screens/dashboard/responsive_screens/dashboard_mobile.dart';
import 'package:dashboard/features/stream/screens/dashboard/responsive_screens/dasktop_tablet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),
    );
  }
}
