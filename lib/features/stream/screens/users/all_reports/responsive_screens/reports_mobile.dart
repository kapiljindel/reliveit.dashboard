import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/screens/reports/all_reports/table/data_table.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ReportsMobileScreen extends StatelessWidget {
  const ReportsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                heading: 'Reports',
                breadcrumbItems: ['Reports'],
              ),
              SizedBox(height: TSizes.spaceBtwSections), // Table Body

              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    ReportTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
