import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/servers/create_server/widgets/create_server_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateServerMobileScreen extends StatelessWidget {
  const CreateServerMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                heading: 'Create Server',
                breadcrumbItems: [TRoutes.servers, 'Create Server'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Form
              CreateServerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
