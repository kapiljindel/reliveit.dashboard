import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/server_model.dart';
import 'package:dashboard/features/stream/screens/servers/edit_server/widgets/edit_server_form.dart';
//import 'package:dashboard/features/stream/screens/server/all_servers/table/table_source.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditServerMobileScreen extends StatelessWidget {
  const EditServerMobileScreen({super.key, required this.server});
  final ServerModel server;

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
                heading: 'Update Server',
                breadcrumbItems: [TRoutes.servers, 'Update Server'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditServerForm(server: server),
            ],
          ),
        ),
      ),
    );
  }
}
