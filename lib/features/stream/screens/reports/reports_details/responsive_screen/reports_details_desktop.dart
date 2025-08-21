import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/reports_model.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/customer_report.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/details.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/widgets/reports_info.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ReportDetailDesktopScreen extends StatelessWidget {
  const ReportDetailDesktopScreen({super.key, required this.report});

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
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Taimoor Sikander',
                breadcrumbItems: [TRoutes.reports, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Report Information
                  Expanded(
                    child: Column(
                      children: [
                        // Report Info
                        ReportInfo(report: report),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        // Shipping Address
                        const ShippingAddress(),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwSections),
                  // Right Side Report Orders
                  const Expanded(flex: 2, child: ReportOrders()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
