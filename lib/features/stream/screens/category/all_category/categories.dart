import 'package:dashboard/features/stream/screens/category/all_category/responsive_screens/categories_desktop.dart';
import 'package:dashboard/features/stream/screens/category/all_category/responsive_screens/categories_mobile.dart';
import 'package:dashboard/features/stream/screens/category/all_category/responsive_screens/categories_tablet.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CategoriesDesktopScreen(),
      tablet: CategoriesTabletScreen(),
      mobile: CategoriesMobileScreen(),
    );
  }
}
