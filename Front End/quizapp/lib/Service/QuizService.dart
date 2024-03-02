

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizapp/Models/QuizModel.dart';
import 'package:quizapp/Models/RankersModel.dart';
import 'package:quizapp/Service/Config.dart';
import 'package:quizapp/main.dart';
import 'package:http/http.dart'as http;
import 'package:quizapp/pages/CongratulationsPage.dart';


class  QuizService {

    static List<QuizModel>quizList = [];

    static List<Rankers>rankers = [];

    static Future<List<QuizModel>> getQuestions({required int quizId})async{
        var response =await http.get(Uri.parse("$getQuestionByCat$quizId"),
        headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json',
			'Authorization': 'Bearer ${MainApp.storage.read("token")}',
		},);
        if(response.statusCode == 200){
            var apiData = jsonDecode(response.body);
            quizList.clear();
            for(Map<String,dynamic> index in apiData){
                quizList.add(QuizModel.fromJson(index));
            }
            return quizList;
        }
        else{
            print("Status Code is: ${response.statusCode}");
        }
        return quizList;
    }

    static Future<void> updateUserScore({required num score})async {
        var response =await http.get(Uri.parse("$updateScore$score"),
         headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json',
			'Authorization': 'Bearer ${MainApp.storage.read("token")}',
		},);

        if(response.statusCode == 200){
            Get.to(() => const CongratulationsPage());
        }
        else{
            if (kDebugMode) {
              print("Status Code is: ${response.statusCode}");
            }
        }
    }

    static Future<void> updateRanks()async{

        var response = await http.get(Uri.parse("$updateRanks"),
        headers: {
            'Content-Type': 'application/json',
			'Accept': 'application/json',
			'Authorization': 'Bearer ${MainApp.storage.read("token")}',
        });

         if(response.statusCode == 200){
            if (kDebugMode) {
                print("Score Updated");
            }
        }
        else{
            if (kDebugMode) {
              print("Status Code is: ${response.statusCode}");
            }
        }
    }

	static Future<List<Rankers>> getRankers()async{

		final response = await http.get(Uri.parse(getRanker),
		headers: {
			'Content-Type' : 'application/json',
			'Accept' : 'application/json',
			'Authorization' : 'Bearer ${MainApp.storage.read('token')}'
		});

		if(response.statusCode == 200){
            rankers.clear();
			var apiData = jsonDecode(response.body);
            
			for (Map<String, dynamic> index in apiData) {
                try {
                    rankers.add(Rankers.fromJson(index));
                } catch (e) {
                    print('Error adding Rankers object: $e');
                }
            }
		}
		else{
			print("Failed to fetch user data. Status code: ${response.statusCode}");
		}

		return rankers;
	}
}