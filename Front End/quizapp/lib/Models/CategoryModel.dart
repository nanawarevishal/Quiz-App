// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    int id;
    String title;
    Category category;
    String catImage;
    List<Question> questions;

    CategoryModel({
        required this.id,
        required this.title,
        required this.category,
        required this.catImage,
        required this.questions,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        category: Category.fromJson(json["category"]),
        catImage: json["catImage"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category.toJson(),
        "catImage": catImage,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    String name;

    Category({
        required this.id,
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Question {
    int id;
    String content;
    Map<String, String> answers;
    int correctAnswer;
    String explanation;

    Question({
        required this.id,
        required this.content,
        required this.answers,
        required this.correctAnswer,
        required this.explanation,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
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
