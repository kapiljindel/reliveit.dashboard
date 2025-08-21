import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/brands/create_brands/widgets/create_brand_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBrandTabletScreen extends StatelessWidget {
  const CreateBrandTabletScreen({super.key});

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
                returnToPreviousScreen: true,
                heading: 'Create Brand',
                breadcrumbItems: [TRoutes.brands, 'Create Brand'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              ///Form
              CreateBrandForm(),
            ],
          ),
        ),
      ),
    );
  }
}
