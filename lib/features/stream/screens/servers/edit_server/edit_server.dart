import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/servers/edit_server/responsive_screens/edit_server_desktop.dart';
import 'package:dashboard/features/stream/screens/servers/edit_server/responsive_screens/edit_server_mobile.dart';
import 'package:dashboard/features/stream/screens/servers/edit_server/responsive_screens/edit_server_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditServerScreen extends StatelessWidget {
  const EditServerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final server = Get.arguments;
    return TSiteTemplate(
      desktop: EditServerDesktopScreen(server: server),
      tablet: EditServerTabletScreen(server: server),
      mobile: EditServerMobileScreen(server: server),
    ); // TSiteTemplate
  }
}
