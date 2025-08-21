import 'package:dashboard/common/widgets/layouts/headers/header.dart';
import 'package:dashboard/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layouts/headers/user_controller.dart';

class DesktopLayout extends StatelessWidget {
  final Widget? body;
  const DesktopLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    Get.put(HeaderUserController());

    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: TSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                const THeader(),

                // BODY
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
