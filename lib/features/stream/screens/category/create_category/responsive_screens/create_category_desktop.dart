import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/category/create_category/widgets/create_category_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateCategoryDesktopScreen extends StatelessWidget {
  const CreateCategoryDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ────── 📌 Breadcrumbs ──────
              TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Category',
                breadcrumbItems: [TRoutes.categories, 'Create Category'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // ────── 📝 Form ──────
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
