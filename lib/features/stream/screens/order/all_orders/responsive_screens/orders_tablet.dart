import 'package:dashboard/features/stream/controllers/order/order_controller.dart';
import 'package:dashboard/features/stream/screens/order/all_orders/table/data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class OrdersTabletScreen extends StatelessWidget {
  OrdersTabletScreen({super.key});

  final VideoItemController controller = Get.put(VideoItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbsWithHeading(
                heading: 'Orders',
                breadcrumbItems: ['Orders'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    const TTableHeader(showLeftWidget: true),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Obx(() {
                      if (controller.videoItems.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return OrderTable(
                        videoItems: controller.videoItems,
                        controller: controller,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
