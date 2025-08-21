import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:dashboard/features/stream/screens/brands/edit_brands/widgets/edit_brand_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});

  final BrandModel brand;

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
                heading: 'Update Brand',
                breadcrumbItems: [TRoutes.brands, 'Update Brand'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditBrandForm(brand: brand),
            ],
          ),
        ),
      ),
    );
  }
}
