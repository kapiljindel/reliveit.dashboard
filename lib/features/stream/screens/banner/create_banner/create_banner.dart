import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/banner/create_banner/responsive_screens/create_banner_desktop.dart';
import 'package:dashboard/features/stream/screens/banner/create_banner/responsive_screens/create_banner_mobile.dart';
import 'package:dashboard/features/stream/screens/banner/create_banner/responsive_screens/create_banner_tablet.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile: CreateBannerMobileScreen(),
    ); // TSiteTemplate
  }
}
