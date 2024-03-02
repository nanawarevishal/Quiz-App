// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
    int id;
    String content;
    Map<String, String> answers;
    int correctAnswer;
    String explanation;

    QuizModel({
        required this.id,
        required this.content,
        required this.answers,
        required this.correctAnswer,
        required this.explanation,
    });

    factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        content: json["content"],
        answers: Map.from(json["answers"]).map((k, v) => MapEntry<String, String>(k, v)),
        correctAnswer: json["correctAnswer"],
        explanation: json["explanation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "answers": Map.from(answers).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "correctAnswer": correctAnswer,
        "explanation": explanation,
    };
}
