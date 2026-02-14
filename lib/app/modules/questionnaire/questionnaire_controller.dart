import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import '../../routes/app_pages.dart';
import '../../data/models/questionnaire_model.dart';
import '../../data/models/submission_model.dart';
import '../../data/services/api_service.dart';

class QuestionnaireController extends GetxController {
  final _apiService = Get.find<ApiService>();
  late QuestionnaireModel questionnaire;
  
  final selectedAnswers = <String, String>{}.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments;
  }

  void selectOption(String questionId, String option) {
    selectedAnswers[questionId] = option;
  }

  bool get allQuestionsAnswered => 
    selectedAnswers.length == questionnaire.questions.length;

  Future<void> submit() async {
    if (!allQuestionsAnswered) {
      Get.snackbar('Error', 'Please answer all questions');
      return;
    }

    isLoading.value = true;
    try {
      // Get location
      Position position = await _determinePosition();
      
      final submission = SubmissionModel(
        questionnaireId: questionnaire.id,
        questionnaireName: questionnaire.title,
        answers: Map<String, String>.from(selectedAnswers),
        submissionDate: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
      );

      final box = Hive.box<SubmissionModel>('submissions');
      await box.add(submission);

      try {
        await _apiService.submitResponse({
          'questionnaireId': questionnaire.id,
          'answers': selectedAnswers,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'submittedAt': submission.submissionDate.toIso8601String(),
        });
      } catch (e) {
        // Silently fail if API is offline
        Get.log('API Sync failed: $e');
      }

      Get.snackbar('Success', 'Questionnaire submitted successfully');
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    } 

    return await Geolocator.getCurrentPosition();
  }
}
