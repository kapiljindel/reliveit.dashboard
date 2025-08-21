import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/servers/create_server/responsive_screens/create_server_desktop.dart';
import 'package:dashboard/features/stream/screens/servers/create_server/responsive_screens/create_server_mobile.dart';
import 'package:dashboard/features/stream/screens/servers/create_server/responsive_screens/create_server_tablet.dart';
import 'package:flutter/material.dart';

class CreateServerScreen extends StatelessWidget {
  const CreateServerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateServerDesktopScreen(),
      tablet: CreateServerTabletScreen(),
      mobile: CreateServerMobileScreen(),
    ); // TSiteTemplate
  }
}
