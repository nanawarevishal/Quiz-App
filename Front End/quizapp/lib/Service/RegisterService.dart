import 'dart:convert';
import 'package:get/get.dart';
import 'package:quizapp/Service/Config.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/components/SnackBar.dart';
import 'package:quizapp/pages/loginPage.dart';

class RegisterService {
  static void registerUser(
      {required String firstNameController,
      required String lastNameController,
      required String emailController,
      required String passwordController}) async {
    if (emailController.isNotEmpty && passwordController.isNotEmpty && firstNameController.isNotEmpty && lastNameController.isNotEmpty) {

        if(!firstNameController.isAlphabetOnly){
            SnacKBar.error(title: "Warning...!", message: "Invalid First Name format");
            return;
        }

        if (!emailController.isEmail) {
            SnacKBar.error(title: "Warning...!", message: "Invalid email Id ");
            return;
        }
      var regBody = {
        "firstName": firstNameController,
        "lastName": lastNameController,
        "email": emailController,
        "password": passwordController
      };

      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        SnacKBar.success(
            title: "Congratulations...!",
            message: "You Have Successfully Registered ");
        Get.to(() => const LoginPage());
      } else {
        SnacKBar.error(title: "Warning...!", message: jsonResponse['message']);
      }
    }

    else{
        SnacKBar.error(title: "Warning...!", message: "Some fields are Empty...!\n Please fill all fields");
    }
  }
}
