//import 'package:dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:dashboard/features/authentication/screens/login/form/authentication_repository.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isAuth = AuthenticationRepository.instance.isAuthenticated;

    if (!isAuth && route != TRoutes.login) {
      return const RouteSettings(name: TRoutes.login);
    }

    if (isAuth && route == TRoutes.login) {
      return const RouteSettings(name: TRoutes.dashboard);
    }

    return null;
  }
}
