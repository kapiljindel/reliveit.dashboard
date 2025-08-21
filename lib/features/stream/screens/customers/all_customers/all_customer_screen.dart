import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/customers/all_customers/responsive_screens/customers_desktop.dart';
import 'package:flutter/material.dart';

class AllCustomersScreen extends StatelessWidget {
  const AllCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CustomersDesktopScreen(),
      //   tablet: CustomersTabletScreen(),
      //   mobile: CustomersMobileScreen(),
    );
  }
}
