import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://69900bf8dcc9a4df204bcd99.mockapi.io/';
  
  static const String register = '/users';
  static const String login = '/users';
  static const String questionnaires = '/questionnaires';
  static const String submissions = '/submissions';
}
