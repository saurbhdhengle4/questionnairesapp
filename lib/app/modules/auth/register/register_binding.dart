import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
