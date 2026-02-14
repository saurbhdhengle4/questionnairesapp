import 'package:get/get.dart';
import '../api_constants.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> register(Map<String, dynamic> data) => post(ApiConstants.register, data);
  
  Future<Response> login(String email, String password) => get(ApiConstants.login, query: {'email': email, 'password': password});

  Future<Response> getQuestionnaires() => get(ApiConstants.questionnaires);

  Future<Response> submitResponse(Map<String, dynamic> data) => post(ApiConstants.submissions, data);
}
