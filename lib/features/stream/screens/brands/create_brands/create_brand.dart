import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/brands/create_brands/responsive_screens/create_brand_desktop.dart';
import 'package:dashboard/features/stream/screens/brands/create_brands/responsive_screens/create_brand_mobile.dart';
import 'package:dashboard/features/stream/screens/brands/create_brands/responsive_screens/create_brand_tablet.dart';
import 'package:flutter/material.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
