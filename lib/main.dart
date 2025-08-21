//import 'package:dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:dashboard/features/authentication/screens/login/form/authentication_repository.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage

  // Remove # sign from url
  setPathUrlStrategy();

  await AuthenticationRepository.instance.checkAuthStatus();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //.then((value) => Get.put(AuthenticationRepository()));

  // Main App Starts here...
  runApp(const App());
}
