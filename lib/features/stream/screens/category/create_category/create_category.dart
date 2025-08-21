import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/category/all_category/responsive_screens/categories_mobile.dart';
import 'package:dashboard/features/stream/screens/category/all_category/responsive_screens/categories_tablet.dart';
import 'package:dashboard/features/stream/screens/category/create_category/responsive_screens/create_category_desktop.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CategoriesTabletScreen(),
      mobile: CategoriesMobileScreen(),
    );
  }
}
