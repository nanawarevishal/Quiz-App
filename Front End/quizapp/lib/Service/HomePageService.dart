import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/Service/Config.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/loginPage.dart';

import '../Models/SingleUserModel.dart';

class HomePageService {

    static Future<dynamic> getUserData() async {
		final response = await http.get(
		Uri.parse(getUser),
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json',
			'Authorization': 'Bearer ${MainApp.storage.read("token")}',
		},
		);

		if (response.statusCode == 200) {
			var apiData = jsonDecode(response.body);
			User user = User.fromJson(apiData);
			return user;
		} else {
			print(response.body);
			// print("Failed to fetch user data. Status code: ${response.statusCode}");
			Get.to(()=>const LoginPage());
		}
  	}
}
