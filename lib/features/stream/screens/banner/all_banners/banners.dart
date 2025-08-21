import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/banner/all_banners/responsive_screens/banners_desktop.dart';
import 'package:dashboard/features/stream/screens/banner/all_banners/responsive_screens/banners_mobile.dart';
import 'package:dashboard/features/stream/screens/banner/all_banners/responsive_screens/banners_tablet.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: BannersDesktopScreen(),
      tablet: BannersTabletScreen(),
      mobile: BannersMobileScreen(),
    );
  }
}
