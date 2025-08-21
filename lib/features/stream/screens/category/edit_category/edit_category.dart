import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:dashboard/features/stream/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:dashboard/features/stream/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';
import 'package:flutter/material.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(categoryId: 'categoryId'),
      tablet: EditCategoriesTabletScreen(categoryId: 'categoryId'),
      mobile: EditCategoriesMobileScreen(categoryId: 'categoryId'),
    );
  }
}
