import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/reports_model.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/customer_report.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/details.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/reports_info.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ReportDetailMobileScreen extends StatelessWidget {
  const ReportDetailMobileScreen({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: report.fullName,
                breadcrumbItems: const [TRoutes.reports, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Report Info
              ReportInfo(report: report),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Shipping Address
              const ShippingAddress(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Left Side Report Orders
              const ReportOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
