import 'package:hive/hive.dart';

part 'submission_model.g.dart';

@HiveType(typeId: 0)
class SubmissionModel extends HiveObject {
  @HiveField(0)
  final String questionnaireId;

  @HiveField(1)
  final String questionnaireName;

  @HiveField(2)
  final Map<String, String> answers;

  @HiveField(3)
  final DateTime submissionDate;

  @HiveField(4)
  final double latitude;

  @HiveField(5)
  final double longitude;

  SubmissionModel({
    required this.questionnaireId,
    required this.questionnaireName,
    required this.answers,
    required this.submissionDate,
    required this.latitude,
    required this.longitude,
  });
}
