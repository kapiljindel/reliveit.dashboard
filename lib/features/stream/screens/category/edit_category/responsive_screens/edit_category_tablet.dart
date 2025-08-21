import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';

class EditCategoriesTabletScreen extends StatelessWidget {
  final String categoryId;

  const EditCategoriesTabletScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // medium padding for tablet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Category',
                breadcrumbItems: [TRoutes.categories, 'Edit Category'],
              ),
              const SizedBox(height: 16.0), // medium spacing for tablet

              EditCategoryForm(categoryId: categoryId),
            ],
          ),
        ),
      ),
    );
  }
}
