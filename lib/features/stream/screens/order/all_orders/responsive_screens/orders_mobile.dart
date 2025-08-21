import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/order/order_controller.dart';
import 'package:dashboard/features/stream/screens/order/all_orders/table/data_table.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersMobileScreen extends StatelessWidget {
  const OrdersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Use Get.put to initialize controller if not already done globally
    final controller = Get.put(VideoItemController());

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

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    const TTableHeader(showLeftWidget: true),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // ✅ Use Obx to listen to controller updates
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
