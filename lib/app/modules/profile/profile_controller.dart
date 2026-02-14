import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../routes/app_pages.dart';
import '../../data/models/submission_model.dart';

class ProfileController extends GetxController {
  final _storage = GetStorage();
  final userData = {}.obs;
  final submissions = <SubmissionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final user = _storage.read('user');
    if (user != null) {
      userData.value = user;
    }
    loadSubmissions();
  }

  void loadSubmissions() {
    final box = Hive.box<SubmissionModel>('submissions');
    submissions.value = box.values.toList().reversed.toList();
  }

  String get email => userData['email'] ?? '';
  String get initial => email.isNotEmpty ? email[0].toUpperCase() : '?';
  int get totalFilled => submissions.length;

  void logout() {
    _storage.remove('user');
    Get.offAllNamed(Routes.login);
  }
}
