import 'package:get/get.dart';
import 'package:dashboard/features/network/network_manager.dart';
import 'package:dashboard/features/authentication/controllers/user_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
