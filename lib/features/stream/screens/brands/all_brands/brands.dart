import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/brands/all_brands/responsive_screens/brands_desktop.dart';
import 'package:dashboard/features/stream/screens/brands/all_brands/responsive_screens/brands_mobile.dart';
import 'package:dashboard/features/stream/screens/brands/all_brands/responsive_screens/brands_tablet.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsTabletScreen(),
      mobile: BrandsMobileScreen(),
    );
  }
}
