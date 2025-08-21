//import 'package:dashboard/common/widgets/containers/round_container.dart';
import 'package:dashboard/common/widgets/layouts/headers/header.dart';
import 'package:dashboard/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

/// Widget for the tablet layout
class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  final Widget? body;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(scaffoldkey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
