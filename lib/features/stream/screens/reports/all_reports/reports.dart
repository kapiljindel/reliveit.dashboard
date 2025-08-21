import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/reports/all_reports/responsive_screens/reports_desktop.dart';
import 'package:dashboard/features/stream/screens/reports/all_reports/responsive_screens/reports_mobile.dart';
import 'package:dashboard/features/stream/screens/reports/all_reports/responsive_screens/reports_tablet.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ReportsDesktopScreen(),
      tablet: ReportsTabletScreen(),
      mobile: ReportsMobileScreen(),
    );
  }
}
