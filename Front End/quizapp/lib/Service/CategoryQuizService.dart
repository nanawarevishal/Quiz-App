
import 'dart:convert';
import 'package:quizapp/Models/CategoryModel.dart';
import 'package:quizapp/main.dart';


import 'Config.dart';
import 'package:http/http.dart' as http;

class CategoryQuizService{

    static List<CategoryModel>categoryQuizList = [];

	

    static Future<List<CategoryModel>> getQuizCategory({required num categoryId})async{

		final response = await http.get(Uri.parse("$getCategoryQuiz$categoryId"),
		headers: {
			'Content-Type' : 'application/json',
			'Accept' : 'application/json',
			'Authorization' : 'Bearer ${MainApp.storage.read('token')}'
		});

		if(response.statusCode == 200){
			var apiData = jsonDecode(response.body);
            categoryQuizList.clear();
            for(Map<String,dynamic> index in apiData){
                categoryQuizList.add(CategoryModel.fromJson(index));
            }
			
		}
		else{
			print("Failed to fetch user data. Status code: ${response.statusCode}");
		}
        return categoryQuizList;
	}

}