import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';

class EditCategoryDesktopScreen extends StatelessWidget {
  final String categoryId;

  const EditCategoryDesktopScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Category',
                breadcrumbItems: [TRoutes.categories, 'Edit Category'],
              ),
              const SizedBox(height: 16.0),

              // Form
              EditCategoryForm(categoryId: categoryId),
            ],
          ),
        ),
      ),
    );
  }
}
