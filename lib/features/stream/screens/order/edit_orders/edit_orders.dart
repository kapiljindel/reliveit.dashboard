// ignore_for_file: unused_local_variable

import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/order/edit_orders/responsive_screens/edit_order_desktop.dart';
import 'package:flutter/material.dart';

class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: EditOrderDesktopScreen(),
      //   mobile: CreateOrderMobileScreen(),
    );
  }
}
