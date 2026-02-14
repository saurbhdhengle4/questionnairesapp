import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';
import '../../../data/models/questionnaire_model.dart';
import '../../../data/services/api_service.dart';

class HomeController extends GetxController {
  final _storage = GetStorage();
  final _apiService = Get.find<ApiService>();

  final userData = {}.obs;
  final questionnaires = <QuestionnaireModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _storage.read('user');
    if (user != null) {
      userData.value = user;
    }
    fetchQuestionnaires();
  }

  Future<void> fetchQuestionnaires() async {
    isLoading.value = true;
    try {
      final response = await _apiService.getQuestionnaires();
      if (response.isOk) {
        final List data = response.body;
        questionnaires.value = data.map((e) => QuestionnaireModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch questionnaires');
    } finally {
      isLoading.value = false;
    }
  }

  String get email => userData['email'] ?? '';
  String get firstName => email.split('@')[0];
  String get initial => email.isNotEmpty ? email[0].toUpperCase() : '?';

  void logout() {
    _storage.remove('user');
    Get.offAllNamed(Routes.login);
  }
}
