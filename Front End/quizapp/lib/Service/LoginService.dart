

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/components/SnackBar.dart';
import 'package:quizapp/pages/HomePage.dart';
import 'package:quizapp/Service/Config.dart';
import 'package:quizapp/main.dart';

class LoginService{

    static void LoginServiceAPI({required TextEditingController emailController,required TextEditingController passwordController,})async{

        if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

            var loginBody ={
                "email":emailController.text,
                "password":passwordController.text
            };

            var response = await http.post(Uri.parse(login),
            headers: {"Content-Type":"application/json"},
            body: jsonEncode(loginBody)
            );
    
            var jsonResponse = jsonDecode(response.body);

            if(jsonResponse['status'] == true){
                MainApp.storage.remove("token");
                MainApp.storage.write("token", jsonResponse['token']);
                SnacKBar.success(title: "Congratulations...!", message: "Login Successfully.\nYou may proceed");
                Get.to(()=>const HomePage());
                
            }

            else{
                SnacKBar.error(title: "Warning...!",message: jsonResponse['message']);
                print(jsonResponse);
            }

        }
       else{
        SnacKBar.error(title: "Warning...!", message: "Some fields are Empty...!\nPlease fill all fields");
     }
    }
}