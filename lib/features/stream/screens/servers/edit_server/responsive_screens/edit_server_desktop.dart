import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/server_model.dart';
import 'package:dashboard/features/stream/screens/servers/edit_server/widgets/edit_server_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditServerDesktopScreen extends StatelessWidget {
  const EditServerDesktopScreen({super.key, required this.server});

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
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Server',
                breadcrumbItems: [TRoutes.servers, 'Edit Server'],
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
