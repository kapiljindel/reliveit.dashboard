import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/servers/all_server/responsive_screens/servers_desktop.dart';
import 'package:dashboard/features/stream/screens/servers/all_server/responsive_screens/servers_mobile.dart';
import 'package:dashboard/features/stream/screens/servers/all_server/responsive_screens/servers_tablet.dart';
import 'package:flutter/material.dart';

class ServersScreen extends StatelessWidget {
  const ServersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ServersDesktopScreen(),
      tablet: ServersTabletScreen(),
      mobile: ServersMobileScreen(),
    );
  }
}
