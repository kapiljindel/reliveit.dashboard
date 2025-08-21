import 'package:dashboard/features/stream/controllers/server/server_controller.dart';
import 'package:dashboard/features/stream/screens/servers/all_server/table/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/routes/routes.dart';

class ServersDesktopScreen extends StatelessWidget {
  final ServerController serverController = Get.put(ServerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (serverController.servers.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumbsWithHeading(
                  heading: 'Servers',
                  breadcrumbItems: ['Servers'],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TRoundedContainer(
                  child: Column(
                    children: [
                      TTableHeader(
                        buttonText: 'Create New Server',
                        onPressed: () => Get.toNamed(TRoutes.createServer),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      ServersTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
