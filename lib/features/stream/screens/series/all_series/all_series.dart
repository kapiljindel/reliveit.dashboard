import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/series/all_series/responsive_screens/series_desktop.dart';
import 'package:flutter/material.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: SeriesDesktopScreen(),
      //   tablet: CustomersTabletScreen(),
      //   mobile: CustomersMobileScreen(),
    );
  }
}
