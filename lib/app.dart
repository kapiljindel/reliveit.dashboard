import 'package:dashboard/bindings/general_bindings.dart';
import 'package:dashboard/common/widgets/page_not_found/page_not_found.dart';
import 'package:dashboard/routes/app_routes.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/text_strings.dart';
import 'package:dashboard/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: TAppRoute.pages,
      initialBinding: GeneralBindings(),
      initialRoute: TRoutes.dashboard,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => PageNotFound(),
      ),
    );
  }
}
