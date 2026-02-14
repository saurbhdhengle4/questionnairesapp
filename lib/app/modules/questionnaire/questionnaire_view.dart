import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'questionnaire_controller.dart';

class QuestionnaireView extends GetView<QuestionnaireController> {
  const QuestionnaireView({super.key});

  @override
  Widget build(BuildContext context) {
    final questionnaire = controller.questionnaire;

    return Scaffold(
      backgroundColor: Color(0xFFFCF8F8),
      appBar: AppBar(
        title: Text(
          questionnaire.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF000080),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFFFCF8F8),
        surfaceTintColor: Color(0xFFFCF8F8),
        iconTheme: IconThemeData(color: Color(0xFF000080)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: questionnaire.questions.length,
              itemBuilder: (context, qIndex) {
                final question = questionnaire.questions[qIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Q ${qIndex + 1}:- ${question.text}',
                            style: const TextStyle(
                              color: Color(0xFF000080),
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ...question.options.map((option) {
                      return Obx(() {
                        final isSelected =
                            controller.selectedAnswers[question.id] == option;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xFF000080)
                                  : Colors.grey[300]!,
                              width: 0.5,
                            ),
                            color: isSelected
                                ? Color(0xFF000080).withValues(alpha: 0.05)
                                : Colors.transparent,
                          ),
                          child: RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: controller.selectedAnswers[question.id],
                            onChanged: (val) =>
                                controller.selectOption(question.id, val!),
                            activeColor: Color(0xFF000080),
                            contentPadding: EdgeInsets.zero,
                          ),
                        );
                      });
                    }),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.submit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF000080),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Submit Response',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
