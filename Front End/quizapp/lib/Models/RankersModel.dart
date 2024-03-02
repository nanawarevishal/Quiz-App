// To parse this JSON data, do
//
//     final rankers = rankersFromJson(jsonString);

import 'dart:convert';

List<Rankers> rankersFromJson(String str) => List<Rankers>.from(json.decode(str).map((x) => Rankers.fromJson(x)));

String rankersToJson(List<Rankers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rankers {
    int id;
    String firstName;
    String lastName;
    String email;
    String password;
    int score;
    int ranks;

    Rankers({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.score,
        required this.ranks,
    });

    factory Rankers.fromJson(Map<String, dynamic> json) => Rankers(
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
