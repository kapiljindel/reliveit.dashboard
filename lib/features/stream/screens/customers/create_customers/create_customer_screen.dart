import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/customers/create_customers/responsive_screens/create_customers_desktop.dart';
import 'package:flutter/material.dart';

class CreateCustomersScreen extends StatelessWidget {
  const CreateCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateCustomersDesktopScreen(),
      //   tablet: CustomersTabletScreen(),
      //   mobile: CustomersMobileScreen(),
    );
  }
}
