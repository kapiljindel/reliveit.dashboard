import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/order/order_controller.dart';
import 'package:dashboard/features/stream/screens/order/all_orders/table/data_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Controller instance
    final controller = Get.put(VideoItemController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                heading: 'Orders',
                breadcrumbItems: ['Orders'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: 'Add Videos',
                      onPressed: () => Get.toNamed(TRoutes.orderDetails),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table with Data
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
