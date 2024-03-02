

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/Service/Config.dart';
import 'package:quizapp/components/SnackBar.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/HomePage.dart';

class ProfilePageService{

    static Future<void> updateProfile(TextEditingController firstNameController,TextEditingController lastNameController)async{

        if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty){

            var requestBody = {
                "firstName":firstNameController.text,
                "lastName":lastNameController.text,
            };

            var response =await http.put(Uri.parse(updateUserRequest),
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${MainApp.storage.read("token")}',},
            body: jsonEncode(requestBody)
            );

            if(response.statusCode == 200){
                Get.to(()=>const HomePage());

                SnacKBar.success(title: "Congratulations...!", message: "Profile Updated Successfully...!");
            }
            else{
                print("Failed status Code: ${response.statusCode}");
            }
        }
    }
}