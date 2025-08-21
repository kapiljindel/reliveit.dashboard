import 'package:dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:dashboard/features/stream/screens/settings/responsive_screens/settings_desktop.dart';
import 'package:dashboard/features/stream/screens/settings/responsive_screens/settings_mobile.dart';
import 'package:dashboard/features/stream/screens/settings/responsive_screens/settings_tablet.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
