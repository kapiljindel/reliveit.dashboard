import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/products/all_products/responsive_screens/products_desktop.dart';
import 'package:dashboard/features/stream/screens/products/all_products/responsive_screens/products_mobile.dart';
import 'package:dashboard/features/stream/screens/products/all_products/responsive_screens/products_tablet.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ProductsDesktopScreen(),
      tablet: ProductsTabletScreen(),
      mobile: ProductsMobileScreen(),
    );
  }
}
