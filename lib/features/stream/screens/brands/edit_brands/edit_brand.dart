import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/brands/edit_brands/responsive_screens/edit_brand_desktop.dart';
import 'package:dashboard/features/stream/screens/brands/edit_brands/responsive_screens/edit_brand_tablet.dart';
import 'package:dashboard/features/stream/screens/brands/edit_brands/responsive_screens/edit_brand_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandsScreen extends StatelessWidget {
  const EditBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;

    return TSiteTemplate(
      //  final brand = BrandModel(id:'id');
      desktop: EditBrandDesktopScreen(brand: brand),
      tablet: EditBrandTabletScreen(brand: brand),
      mobile: EditBrandMobileScreen(brand: brand),
    );
  }
}
