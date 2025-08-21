import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/category/create_category/widgets/create_category_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';

class CreateCategoryTabletScreen extends StatelessWidget {
  const CreateCategoryTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24), // medium padding for tablet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Category',
                breadcrumbItems: [TRoutes.categories, 'Create Category'],
              ),
              SizedBox(height: 16), // medium spacing for tablet
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
