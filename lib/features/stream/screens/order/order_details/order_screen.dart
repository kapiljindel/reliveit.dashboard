import 'package:dashboard/features/stream/screens/order/order_details/create_order_page.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
//import 'responsive_screens/order_detail_desktop.dart';
//import 'responsive_screens/order_detail_mobile.dart';
//import 'responsive_screens/order_detail_tablet.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final order = Get.arguments;

    return TSiteTemplate(
      desktop: CreateVideoItemPage(),
      //    tablet: OrderDetailTabletScreen(order: order),
      //  mobile: OrderDetailMobileScreen(order: order),
    );
  }
}
