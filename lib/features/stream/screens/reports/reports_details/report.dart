import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/responsive_screen/reports_details_desktop.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/responsive_screen/reports_details_mobile.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/responsive_screen/reports_details_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Get.arguments;

    return TSiteTemplate(
      desktop: ReportDetailDesktopScreen(report: report),
      tablet: ReportDetailTabletScreen(report: report),
      mobile: ReportDetailMobileScreen(report: report),
    );
  }
}
