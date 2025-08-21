// ignore_for_file: unused_local_variable

import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/products/edit_products/responsive_screens/edit_product_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    return TSiteTemplate(
      desktop: EditProductDesktopScreen(product: product),
      //   mobile: CreateProductMobileScreen(),
    );
  }
}
