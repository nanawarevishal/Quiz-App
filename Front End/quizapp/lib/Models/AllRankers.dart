// To parse this JSON data, do
//
//     final ranker = rankerFromJson(jsonString);

import 'dart:convert';

List<Ranker> rankerFromJson(String str) => List<Ranker>.from(json.decode(str).map((x) => Ranker.fromJson(x)));

String rankerToJson(List<Ranker> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ranker {
    int id;
    String firstName;
    dynamic lastName;
    String email;
    String password;
    int score;
    int ranks;

    Ranker({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.score,
        required this.ranks,
    });

    factory Ranker.fromJson(Map<String, dynamic> json) => Ranker(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        score: json["score"],
        ranks: json["ranks"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "score": score,
        "ranks": ranks,
    };
}
