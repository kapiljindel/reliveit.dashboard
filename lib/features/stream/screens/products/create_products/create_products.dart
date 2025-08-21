import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/products/create_products/responsive_screens/create_product_desktop.dart';
import 'package:dashboard/features/stream/screens/products/create_products/responsive_screens/create_product_mobile.dart';
import 'package:dashboard/features/stream/screens/products/create_products/responsive_screens/create_product_tablet.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      tablet: CreateProductTabletScreen(),
      mobile: CreateProductMobileScreen(),
    );
  }
}
